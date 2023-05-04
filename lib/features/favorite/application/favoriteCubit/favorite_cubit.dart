import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/functions/utils_functios.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/favorite/application/favoriteCubit/favorite_states.dart';

import '../../../form/data/model/house_model.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  //Variables
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Methods

//get Favorite Houses
  Future getFavoriteHouses() async {
    emit(FavoriteLoadingState());
    final UserModel oldUser = await getDataFromSharedPref();
    QuerySnapshot query = await _firestore
        .collection("users")
        .where("userId", isEqualTo: oldUser.userId)
        .get();
    query.docs.forEach((element) async {
      final data = element.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromMap(data);

      //get houses fav ids of the user:
      final userFields =
          await _firestore.collection("users").doc(user.userId).get();

      List ids = userFields.get("favHouses");
      print(ids);

      try {
        List<HouseModel> houses = [];
        if (ids.length == 0) {
          emit(FavoriteHousesEmptyState());
        } else {
          for (int i = 0; i < ids.length; i++) {
            QuerySnapshot query = await _firestore
                .collection("houses")
                .where("houseId", isEqualTo: ids[i])
                .get();

            if (query.docs.isNotEmpty) {
              query.docs.map<List<HouseModel>>((e) {
                final data = e.data() as Map<String, dynamic>;

                final HouseModel houseModel = HouseModel.fromMap(data);
                houses.add(houseModel);
                return houses;
              }).toList();
              emit(FavoriteHousesLoadedState(houses: houses));
            } else {
              emit(FavoriteHousesEmptyState());
            }
          }
        }
      } catch (e) {
        emit(FavoriteErrorState(e.toString()));
      }
    });
  }
}
