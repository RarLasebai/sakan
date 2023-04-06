// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Radios { married, single }

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());

  static SignupCubit get(context) => BlocProvider.of(context);

  //Firebase instance
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Variables
  TextEditingController addressController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpTwoFormKey = GlobalKey<FormState>();

  String groupValue = "";
  String pin = "";
  String? userId;
  UserModel? fullUserModel;

  //Functions
  onChanged(value) {
    //this one is for the radio button
    groupValue = value;
    print(groupValue);
    emit(RadioButtonChangeState(value));
  }

  Future setSignin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_signed_in", true);
  }

//Verifing Functions, one for phone and one for OTP:
  //verfiy phone number

  void verfiyPhone(
      {required String phone, required BuildContext context}) async {
    emit(SignupLoadingState());
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+2189${phone.toString()}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              showToast(context, 'invalid-phone-number');
            }
            emit(SignupErrorState(e.toString()));
          },
          codeSent: (String verificationId, int? resendToken) async {
            emit(CodeSentSuccessState(verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }
  //verfiy OTP

  void verfiyOtp(
      {required BuildContext context,
      required String otp,
      required String verificationId,
      required Function onSuccess}) async {
    emit(SignupLoadingState());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      User? user = ((await auth.signInWithCredential(credential)).user);

      if (user != null) {
        //uuser verified
        userId = user.uid;
        onSuccess(userId: userId);
      }
      emit(OtpVerifiedSuccessState());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      emit(OtpWrongState());
    }
  }

//Firebase Operations

  Future<bool> checkUserExist() async {
    DocumentSnapshot snapshot =
        await firestore.collection("users").doc(userId).get();
    if (snapshot.exists) {
      print("USER EXIST");
      return true;
    } else {
      print("NEW USER ");
      return false;
    }
  }

  void saveUserDataToFirebase(
      {required UserModel userModel,
      required BuildContext context,
      required Function onSuccess}) async {
    emit(SignupLoadingState());

    try {
      //update data
      userModel.userId = auth.currentUser!.uid;
      userModel.userPhone = "+2189${userModel.userPhone}";
      fullUserModel = userModel;
      //upload to fire base
      await firestore
          .collection("users")
          .doc(userId)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        emit(SignupSuccessState());
      });
    } on FirebaseAuthException catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }

  //store data locally
  Future storeDataLocally() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        "user_model", jsonEncode(fullUserModel!.toMap()));
  }

  //show-hide password
  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePassVisibilty() {
    print("object");
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SignupChangePassVisibiltyState());
  }
}
