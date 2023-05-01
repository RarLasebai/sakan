import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  List houseTypes = ["شقة", "منزل أرضي", "منزل بدورين", "أخرى"];
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
}
