// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/foget_pass_states.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/auth/presentation/screens/change_password_screen.dart';
import 'package:sakan/features/auth/presentation/widgets/pinput_widget.dart';

class RestorePassOtpScreen extends StatelessWidget {
  final String verificationId;
  final UserModel userModel;
  final ForgetPassCubit forgetPassCubit;

  const RestorePassOtpScreen(
      {super.key,
      required this.forgetPassCubit,
      required this.verificationId,
      required this.userModel});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
    TextEditingController otpController = TextEditingController();

    return BlocProvider.value(
      value: BlocProvider.of<ForgetPassCubit>(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: otpFormKey,
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
                    "لقد أرسلنا رمز التأكيد إلى ${userModel.userPhone} يرجى إدخاله",
                    12,
                    darkGrey,
                    FontWeight.normal,
                    longText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                        child: PinputWidget(otpController: otpController)),
                  ),
                  BlocConsumer<ForgetPassCubit, ForgetPassStates>(
                      listener: (context, state) {
                    if (state is ForgetPassVerifiedState) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                value: forgetPassCubit,
                                child: ChangePasswordScreen(
                                  forgetPassCubit: forgetPassCubit,
                                  userModel: userModel,
                                ))),
                        (Route<dynamic> route) => false,
                      );
                    }
                    if (state is ForgetPassWrongOTpState) {
                      showToast(context,
                          "تحقق من الرمز المرسل إليك وأعد إدخاله مجدداً!");
                    }
                  }, builder: (context, signupState) {
                    if (signupState is SignupLoadingState) {
                      return const LoadingWidget();
                    } else {
                      return CustomButton(
                          text: "تحقق",
                          onTap: () {
                            if (otpFormKey.currentState!.validate()) {
                              forgetPassCubit.verfiyOtp(
                                otp: otpController.text.toString(),
                                verificationId: verificationId,
                              );
                            }
                          });
                    }
                  }),
                  SizedBox(
                    height: 7.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      forgetPassCubit.verfiyPhone(
                          phone: userModel.userPhone, user: userModel);
                      otpController.clear();
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
