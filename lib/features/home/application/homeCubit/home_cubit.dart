// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/functions/utils_functios.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/home/application/homeCubit/home_states.dart';

import '../../../form/data/model/house_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  //Variables
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //house images CarouselSlider
  int currentIndex = 0;
  int? selectedIndex = 0;
  var fav = Colors.white;
  int? nCounter;
  int? sadCounter;
  int? smileCounter;
  List houseTypes = [
    "شقة",
    "منزل أرضي",
    "منزل بدورين",
    "شاليه",
    "جاراج",
    "أخرى",
  ];
  //Methods
  //house images CarouselSlider
  void houseImageChanges(int index) {
    currentIndex = index;
    emit(HouseIndexChangeState());
  }

//get Houses
  Future getLatestHouses() async {
    emit(HomeLoadingState());
    try {
      List<HouseModel> houses = [];
      // print(userId);
      QuerySnapshot query = await _firestore
          .collection("houses")
          .where("houseState", isEqualTo: "accepted")
          .get();

      if (query.docs.isNotEmpty) {
        query.docs.map<List<HouseModel>>((e) {
          final data = e.data() as Map<String, dynamic>;

          final HouseModel houseModel = HouseModel.fromMap(data);
          houses.add(houseModel);
          return houses;
        }).toList();

        emit(LatestHousesLoadedState(houses: houses));
      } else {
        emit(HomeErrorState("لا توجد مساكن في قاعدة البيانات"));
      }
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  //get house with type
  Future getHouseWithType(String houseType) async {
    emit(HouseWithTypeLoadingState());
    try {
      List<HouseModel> houses = [];
      // print(userId);
      QuerySnapshot query = await _firestore
          .collection("houses")
          .where("houseType", isEqualTo: houseType)
          .where("houseState", isEqualTo: "accepted")
          .get();

      if (query.docs.isNotEmpty) {
        query.docs.map<List<HouseModel>>((e) {
          final data = e.data() as Map<String, dynamic>;

          final HouseModel houseModel = HouseModel.fromMap(data);
          houses.add(houseModel);
          return houses;
        }).toList();

        emit(HouseWithTypeLoadedState(houses: houses));
      } else {
        emit(NoHousesInThisTypeState("لا توجد مساكن في هذه الفئة بعد "));
      }
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  Future checkHouseIsInFav(String houseId) async {
    UserModel user = await getDataFromSharedPref();
    //store in the firestore
    if (user.favHouses!.contains(houseId)) {
      fav = primary;

      emit(FavColorChangeState());
    } else {
      fav = Colors.white;

      emit(FavColorChangeState());
    }
  }

  Future addToFav(String houseId) async {
    UserModel user = await getDataFromSharedPref();
    //store in the firestore
    emit(AddHouseToFavLoadingState());
    try {
      if (user.favHouses!.contains(houseId)) {
        await _firestore.collection("users").doc(user.userId).update({
          "favHouses": FieldValue.arrayRemove([houseId]),
        });
        fav = Colors.white;
        emit(RemoveHouseFromFavSuccessState());
      } else {
        await _firestore.collection("users").doc(user.userId).update({
          "favHouses": FieldValue.arrayUnion([houseId]),
        });
        fav = primary;

        emit(AddHouseToFavSuccessState());
      }
      QuerySnapshot query = await _firestore
          .collection("users")
          .where("userId", isEqualTo: user.userId)
          .get();

      query.docs.forEach((element) async {
        final data = element.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromMap(data);
        await storeDataLocally(user);
      });
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  Future<HouseModel> getHouse(String houseId) async {
    DocumentSnapshot<Map<String, dynamic>> house =
        await _firestore.collection("houses").doc(houseId).get();
    HouseModel h = HouseModel.fromMap(house.data()!);
    sadCounter = h.sadCount;
    smileCounter = h.smileCount;
    nCounter = h.neutralCount;
    return h;
  }

  Future impressionUpdate(
      {required HouseModel houseModel, required int value}) async {
    String fieldName = "smileCount";
    int counter = 0;
    if (value > 0 && value < 3) {
      fieldName = "sadCount";
      sadCounter = sadCounter! + 1;
      counter = sadCounter!;
    } else if (value == 3) {
      fieldName = "neutralCount";
      nCounter = nCounter! + 1;
      counter = nCounter!;
    } else {
      fieldName = "smileCount";
      smileCounter = smileCounter! + 1;
      counter = smileCounter!;
    }
    try {
      emit(HomeLoadingState());

      await _firestore
          .collection("houses")
          .doc(houseModel.houseId)
          .update({fieldName: counter});
      emit(HouseImpressionUpdatedState(
          nCounter: nCounter!,
          sadCounter: sadCounter!,
          smileCounter: smileCounter!));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}
