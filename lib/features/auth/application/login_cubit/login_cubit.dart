// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/auth/application/login_cubit/login_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  //Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Functions
  Future login({required String phone, required String pass}) async {
    emit(LoginLoadingState());

    try {
      QuerySnapshot query = await _firestore
          .collection("users")
          .where("userPhone", isEqualTo: "+2189$phone")
          .where("userPassword", isEqualTo: pass)
          .get();

      if (query.docs.isNotEmpty) {
        query.docs.forEach((element) {
          final data = element.data() as Map<String, dynamic>;
          UserModel user = UserModel.fromMap(data);
          setSignin();
          emit(LoginSuccessState(user));
        //then set shared pref
          try {
            storeDataLocally(user);
            print("saved");
          } catch (e) {
            emit(UserNotSavedLocally("لم يتم تخزين المستخدم في الجهاز"));
          }
        });
      } else {
        emit(UserNotFoundState());
      }
    } catch (e) {
      emit(UserNotSavedLocally(e.toString()));
    }
  }

  //store data locally
  Future storeDataLocally(UserModel userModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        "user_model", jsonEncode(userModel.toMap()));
  }

  Future setSignin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_signed_in", true);
  }
}
