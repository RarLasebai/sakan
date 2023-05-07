// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/functions/utils_functios.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/form/data/model/house_model.dart';
import 'form_states.dart';

class FormCubit extends Cubit<FormStates> {
  FormCubit() : super(FormInitialState());

  static FormCubit get(context) => BlocProvider.of(context);

// Variables
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController priceController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController colorsController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController kitchenController = TextEditingController();
  TextEditingController toiletController = TextEditingController();
  TextEditingController minRentPeriodController = TextEditingController();
  GlobalKey<FormState> formDataKey = GlobalKey<FormState>();
  List<XFile>? imagesFile;
  LatLng? houseLocation;
  String location = "";
  List<String> images = [];
  List<Marker> marker = <Marker>[
    Marker(
      point: LatLng(32.885353, 13.180161),
      builder: (BuildContext context) {
        return const Icon(
          Icons.location_on,
          size: 50,
          color: primary,
        );
      },
    )
  ];
//Radio Buttons
  String groupValue = "";
  String furnitureGroupValue = "";
  String elecGroupValue = "";
  String waterGroupValue = "";
  String wifiGroupValue = "";

//Radio button Functions
  houseTypeOnChanged(value) {
    groupValue = value;
    print(groupValue);
    emit(FormRadioButtonChangedState(value));
  }

  furnitureOnChanged(value) {
    furnitureGroupValue = value;
    print(furnitureGroupValue);
    emit(FormRadioButtonChangedState(value));
  }

  elecOnChanged(value) {
    elecGroupValue = value;
    print(elecGroupValue);
    emit(FormRadioButtonChangedState(value));
  }

  waterOnChanged(value) {
    waterGroupValue = value;
    print(waterGroupValue);
    emit(FormRadioButtonChangedState(value));
  }

  wifiOnChanged(value) {
    wifiGroupValue = value;
    print(wifiGroupValue);
    emit(FormRadioButtonChangedState(value));
  }

  /////////////////////

  String getLatLong(Marker newMarker) {
    String lat = newMarker.point.latitude.toStringAsFixed(4);
    String long = newMarker.point.longitude.toStringAsFixed(4);

    String location = "$lat, $long";
    print("From getLatLong Function: $location");
    return location;
  }

  Future<bool> isManyRequests(String userId) async {
    List<HouseModel> houses = [];
    // print(userId);
    QuerySnapshot query = await _firestore
        .collection("houses")
        .where("userId", isEqualTo: userId)
        .where("houseState", isEqualTo: "sent")
        .get();

    if (query.docs.isNotEmpty) {
      query.docs.map<List<HouseModel>>((e) {
        final data = e.data() as Map<String, dynamic>;

        final HouseModel houseModel = HouseModel.fromMap(data);
        houses.add(houseModel);
        return houses;
      }).toList();
    }
    //limit for requests is just 2 only..
    if (houses.length > 1) {
      emit(ManyRequestsState(
          "لقد وصلت للحد الأقصى، يمكنك المحاولة مجدداً عندما يتم تحديد حالة نماذجك السابقة"));

      return true;
    } else {
      return false;
    }
  }

  void saveHouseDataToFirebase(BuildContext context) async {
    emit(FormLoadingState());
    UserModel userModel = await getDataFromSharedPref();
    final userId = userModel.userId;
    bool isManyRequest = await isManyRequests(userId);
    if (isManyRequest == true) {
      emit(ManyRequestsState(
          "لقد وصلت للحد الأقصى، يمكنك المحاولة مجدداً عندما يتم تحديد حالة نماذجك السابقة"));
      resetVariables();
    } else {
      try {
        //generating houseID
        final houseId = _firestore.collection("houses").doc();
        //upload images to firestore
        images = await uploadImagesFunction(houseId.id);

        if (images.isEmpty) {
          emit(PickingImageErrorState("حدث خطأ أثناء رفع الصور، حاول مجدداً"));
        } else if (groupValue.isEmpty) {
          emit(HouseTypeErrorState("من فضلك حدد نوع السكن!"));
        } else if (furnitureGroupValue.isEmpty ||
            elecGroupValue.isEmpty ||
            waterGroupValue.isEmpty ||
            wifiGroupValue.isEmpty) {
          emit(HouseTypeErrorState(
              "من فضلك أجب عن جميع الأسئلة المطروحة بالأسفل"));
        } else {
          DateTime today = DateTime.now();
          String date = "${today.day}-${today.month}-${today.year}";

          //set the model then save it to firebase cloud
          HouseModel houseModel = HouseModel(
              houseId: houseId.id,
              houseArea: areaController.text,
              houseColors: colorsController.text,
              houseDesc: descController.text,
              housePrice: priceController.text,
              houseType: groupValue,
              date: date,
              houseImages: images,
              houseLocation: locationController.text,
              userId: userId,
              elec: elecGroupValue == "نعم" ? true : false,
              furniture: furnitureGroupValue == "نعم" ? true : false,
              kitchenCount: int.parse(kitchenController.text),
              minRentPeriod: int.parse(minRentPeriodController.text),
              roomsCount: int.parse(roomsController.text),
              toiletCount: int.parse(toiletController.text),
              water: waterGroupValue == "نعم" ? true : false,
              wifi: wifiGroupValue == "نعم" ? true : false);

          await _firestore
              .collection("houses")
              .doc(houseId.id)
              .set(houseModel.toMap())
              .then((value) {
            resetVariables();
            emit(FormSentSuccessfuly());
          });
        }
      } on FirebaseAuthException catch (e) {
        emit(FormErrorState(e.toString()));
      }
    }
  }

  Future<List<XFile>?> pickMultiImages() async {
    late List<XFile>? images = [];

    try {
      emit(PickingImageLoadingState());

      final pickedImages = await ImagePicker().pickMultiImage();

      // ignore: unnecessary_null_comparison
      if (pickedImages != null) {
        images.addAll(pickedImages);
        print("list of images is ${pickedImages.length}");
        emit(PickingImageSuccessState());
      }
    } catch (e) {
      print("error $e");
    }
    return images;
  }

  Future uploadImagesFunction(String houseId) async {
    final List<String> imagesUrl = [];
    // final imagesFile = await pickMultiImages();
    for (int i = 0; i < imagesFile!.length; i++) {
      final String imageURL = await storeFileToStorage(
          "housePics/$houseId/$i", File(imagesFile![i].path));
      imagesUrl.add(imageURL);
      print("url = $imageURL");
    }
    return imagesUrl;
  }

  void resetVariables() {
    priceController.clear();
    areaController.clear();
    locationController.clear();
    descController.clear();
    colorsController.clear();
    minRentPeriodController.clear();
    roomsController.clear();
    kitchenController.clear();
    toiletController.clear();
    groupValue = "";
    wifiGroupValue = "";
    waterGroupValue = "";
    furnitureGroupValue = "";
    elecGroupValue = "";
  }
}
