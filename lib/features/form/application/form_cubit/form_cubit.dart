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
  GlobalKey<FormState> formDataKey = GlobalKey<FormState>();
  List<XFile>? imagesFile;
  LatLng? houseLocation;
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

  String groupValue = "";

//Functions
  houseTypeOnChanged(value) {
    groupValue = value;
    print(groupValue);
    emit(FormRadioButtonChangedState(value));
  }

  String getLatLong() {
    String lat = marker.first.point.latitude.toString();
    String long = marker.first.point.longitude.toString();

    String location = "$lat, $long";

    return location;
  }

  void saveHouseDataToFirebase(BuildContext context) async {
    emit(FormLoadingState());
    try {
      UserModel userModel = await getDataFromSharedPref();
      final userId = userModel.userId;
      String location = getLatLong();
      //generating houseID
      final houseId = _firestore.collection("houses").doc();
      //upload images to firestore
      images = await uploadImagesFunction(houseId.id);

      if (images.isEmpty) {
        emit(PickingImageErrorState("حدث خطأ أثناء رفع الصور، حاول مجدداً"));
      } else if (groupValue.isEmpty) {
        emit(HouseTypeErrorState("من فضلك حدد نوع السكن!"));
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
            houseLocation: location,
            userId: userId);

        await _firestore
            .collection("houses")
            .doc(houseId.id)
            .set(houseModel.toMap())
            .then((value) {
          priceController.clear();
          areaController.clear();
          locationController.clear();
          descController.clear();
          colorsController.clear();
          groupValue = "";
          emit(FormSentSuccessfuly());
        });
      }
    } on FirebaseAuthException catch (e) {
      emit(FormErrorState(e.toString()));
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
}
