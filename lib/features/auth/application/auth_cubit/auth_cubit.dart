// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isSignedin = false;
  UserModel? userModel;

  void checkSign() async {
    emit(AuthLoadingState());
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      isSignedin = sharedPreferences.getBool("is_signed_in") ?? false;
      if (isSignedin == true) {
        UserModel userModel = await getDataFromSharedPref();
        print('Go To Home');
        emit(AuthSuccessState(userModel));
      } else {
        print('Go To Boarding');
        emit(AuthFailState());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  //get data from sharedPreferences, if the user is Authenticated "signed in".
  Future<UserModel> getDataFromSharedPref() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String data = sharedPreferences.getString("user_model") ?? '';
    final userModel = UserModel.fromMap(jsonDecode(data));
    emit(AuthGetUser(userModel));
    return userModel;
  }

  Future signOut() async {
    await auth.signOut();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_signed_in", false);
  }
}
