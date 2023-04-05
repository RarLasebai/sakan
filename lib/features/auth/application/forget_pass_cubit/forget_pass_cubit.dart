// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/foget_pass_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassCubit extends Cubit<ForgetPassStates> {
  ForgetPassCubit() : super(ForgetPassInitialState());

  static ForgetPassCubit get(context) => BlocProvider.of(context);

//Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? userModel;

//Functions

  //1- check if phone is stored in firestore
  Future checkPhoneExist(String phone) async {
    emit(ForgetPassLoadingState());
    try {
      QuerySnapshot query = await _firestore
          .collection("users")
          .where("userPhone", isEqualTo: "+2189$phone")
          .get();
      if (query.docs.isNotEmpty) {
        query.docs.forEach((element) {
          final data = element.data() as Map<String, dynamic>;
          UserModel user = UserModel.fromMap(data);
          emit(UserFoundState(user));
          verfiyPhone(phone: phone, user: user);
        });
      } else {
        emit(ForgetPassUserNotFoundState());
      }
    } catch (e) {
      emit(ForgetPassErrorState(e.toString()));
    }
  }

  void verfiyPhone({required String phone, required UserModel user}) async {
    emit(ForgetPassLoadingState());
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+2189${phone.toString()}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) async {
            emit(ForgetPassCodeSentState(verId: verificationId, user: user));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      emit(ForgetPassErrorState(e.toString()));
    }
  }
  //2- verify with otp

  void verfiyOtp({
    required String otp,
    required String verificationId,
  }) async {
    emit(ForgetPassLoadingState());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      User? user = ((await auth.signInWithCredential(credential)).user);

      if (user != null) {
        print("uuser verified");
      }
      emit(ForgetPassVerifiedState());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      emit(ForgetPassWrongOTpState());
    }
  }

  //3- save the new pass
  Future changePass(
      {required UserModel userModel, required String pass}) async {
    emit(ForgetPassLoadingState());
    try {
      await _firestore
          .collection("users")
          .doc(userModel.userId)
          .update({"userPassword": pass});
      storeDataLocally(userModel);
      emit(PasswordChangedSuccessState());
    } catch (e) {
      emit(ForgetPassErrorState(e.toString()));
    }
  }

  //4- login and save login
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
