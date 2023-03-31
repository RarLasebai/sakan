// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/screens/home_layout.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_snack_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_cubit.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/auth/presentation/screens/login_screen.dart';
import 'package:sakan/features/auth/presentation/screens/sign_up_two_screen.dart';
import 'package:sakan/features/auth/presentation/widgets/pinput_widget.dart';

class OtpVerficationScreen extends StatelessWidget {
  final String verificationId, phoneNumber, name, personalProof, password;
  final SignupCubit signupCubit;

  const OtpVerficationScreen(
      {super.key,
      required this.signupCubit,
      required this.verificationId,
      required this.phoneNumber,
      required this.name,
      required this.password,
      required this.personalProof});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SignupCubit>(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: signupCubit.otpFormKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TxtStyle(
                    "تأكيد رقم الهاتف",
                    22,
                    Colors.black,
                    FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TxtStyle(
                    "لقد أرسلنا رمز التأكيد إلى ${"09$phoneNumber"} يرجى إدخاله",
                    12,
                    darkGrey,
                    FontWeight.normal,
                    longText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                        child: PinputWidget(
                            otpController: signupCubit.otpController)),
                  ),
                  BlocConsumer<SignupCubit, SignupStates>(
                      listener: (context, signupState) {
                    if (signupState is SignupSuccessState) {
                      print("SignupSuccessState");
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const SignUpTwoScreen()),
                      //     (Route<dynamic> route) => false);
                    }
                  }, builder: (context, signupState) {
                    // SignupCubit signupCubit = SignupCubit.get(context);
                    if (signupState is SignupLoadingState) {
                      return const LoadingWidget();
                    } else {
                      return CustomButton(
                          text: "تحقق",
                          onTap: () {
                            print("OTP ${signupCubit.pin}");
                            if (signupCubit.otpFormKey.currentState!
                                .validate()) {
                              signupCubit.verfiyOtp(
                                  context: context,
                                  otp:
                                      signupCubit.otpController.text.toString(),
                                  verificationId: verificationId,
                                  onSuccess: ({required String userId}) {
                                    //after verify phone number and OTP, then check if user exist in DB or not
                                    //if exist? then user is going to Login

                                    signupCubit.checkUserExist().then((value) {
                                      if (value == true) {
                                        //user exist
                                        print("USER EXIST in FireBase ONLY!");
                                        //that means the phone is used before
                                        showSnackBar(context,
                                            "رقم الهاتف مستخدم مسبقاً، سجل الدخول أو قم بتغيير كلمة السر");
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()),
                                            (Route<dynamic> route) => false);
                                      } else {
                                        //new user
                                        print("NEW USER");
                                        //save the new user data to the firestore
                                        UserModel userModel = UserModel(
                                            userName: name,
                                            userId: userId,
                                            userPhone: phoneNumber,
                                            userPassword: password,
                                            userPersonalProof: personalProof,
                                            userMartialStatus: "",
                                            userNationality: "",
                                            userAddress: "");

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: signupCubit,
                                                    child: SignUpTwoScreen(
                                                      signupCubit: signupCubit,
                                                      userModel: userModel,
                                                    ),
                                                  )),
                                        );
                                      }
                                    });
                                  });
                            }
                          });
                    }
                  }),
                  SizedBox(
                    height: 7.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      signupCubit.verfiyPhone(
                          phone: phoneNumber, context: context);
                      signupCubit.otpController.clear();
                    },
                    child: const TxtStyle(
                      "إعادة إرسال الرمز؟",
                      12,
                      Colors.black,
                      FontWeight.normal,
                      textDecoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
