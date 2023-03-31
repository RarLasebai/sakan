import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/foget_pass_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';

class ForgetPassCubit extends Cubit<ForgetPassStates> {
  ForgetPassCubit() : super(ForgetPassInitialState());

  static ForgetPassCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
//Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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
  //verfiy OTP

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
        // userId = user.uid;
        // onSuccess(userId: userId);
      }
      emit(ForgetPassVerifiedState());
    } on FirebaseAuthException catch (e) {
      emit(ForgetPassErrorState(e.toString()));
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
      emit(PasswordChangedSuccessState());
    } catch (e) {
      emit(ForgetPassErrorState(e.toString()));
    }
  }
  //4- login and save login

}
