// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/form/data/model/house_model.dart';
import 'package:sakan/features/home/application/searchCubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  //Variables
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();
  List? allHouses;
  //Methods
  getSearchResult({var searchWord}) async {
    QuerySnapshot query;
    // bool isNumber = isNumericUsingRegularExpression(searchWord);

    emit(SearchLoadingState());

    try {
      List<HouseModel> houses = [];
      // print(userId);

      query = await _firestore
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
        allHouses = houses;
        emit(SearchResultLoadedState(houses: houses));
      } else {
        emit(SearchResultEmptyState("لا توجد نتائج مطابقة!"));
      }
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  //suggestions
  void searchHouse(String query, List allHouses) {
    final bool isNumber = isNumericUsingRegularExpression(query);
    print(isNumber);
    final sug = allHouses.where((house) {
      final dynamic houseQuery;
      if (isNumber == true) {
        houseQuery = house.housePrice.toLowerCase();
      } else {
        houseQuery = house.houseArea.toLowerCase();
      }
      final input = query.toLowerCase();
      return houseQuery.contains(input);
    }).toList();
    if (sug.isNotEmpty) {
      emit(SearchResultLoadedState(houses: sug));
    } else {
      emit(SearchResultEmptyState("لا توجد نتائج متطابقة!"));
    }
  }
  void filterSearch(String filter, List allHouses) {
  final sug = allHouses.where((house) {
    final dynamic houseQuery;
    if (filter == "cost") {
      houseQuery = house.housePrice.toLowerCase();
    } else if (filter == "toilet") {
      houseQuery = int.parse(house.toiletCount);
    } else if (filter == "kitchen") {
      houseQuery = int.parse(house.kitchenCount);
    } else if (filter == "rooms") {
      houseQuery = int.parse(house.roomsCount);
    } else {
      houseQuery = house.houseArea.toLowerCase();
    }

    return houseQuery;
  }).toList();
}

}


// يختار لو كان على عدد المطابخ أو نوع الفلتر، وبناءً عليه يصير الريكويست وتطلع النتائج بعدين تصير الفلترة الثانية

//check if string in number or not
bool isNumericUsingRegularExpression(String string) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  return numericRegex.hasMatch(string);
}
