// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/foget_pass_states.dart';
import 'package:sakan/features/auth/presentation/screens/restore_pass_otp_screen.dart';

import '../../application/forget_pass_cubit/forget_pass_cubit.dart';

class RestorePasswordScreen extends StatelessWidget {
  final bool isProfile;
  const RestorePasswordScreen({super.key, this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();

    GlobalKey<FormState> restorePasswordFormKey = GlobalKey<FormState>();

    return BlocProvider.value(
      value: ForgetPassCubit(),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: isProfile
                ? const TxtStyle("الإعدادات", 18, Colors.black, FontWeight.bold)
                : null,
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black)),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: restorePasswordFormKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isProfile == false
                      ? Image.asset("assets/images/demo.png")
                      : const SizedBox(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 16),
                    child: Center(
                      child: TxtStyle("استرجاع كلمة المرور", 18, Colors.black,
                          FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 20),
                    child: CustomTextField(
                      hint: "رقم الهاتف",
                      isPhone: true,
                      isNumbers: true,
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك لا تترك الحقل فارغاً";
                        } else if (value.characters.length < 8) {
                          return "من فضلك تأكد من رقم الهاتف";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  BlocConsumer<ForgetPassCubit, ForgetPassStates>(
                      listener: (context, state) {
                    ForgetPassCubit forgetPassCubit =
                        ForgetPassCubit.get(context);
                    if (state is UserFoundState) {
                      print("user found");
                    } else if (state is ForgetPassUserNotFoundState) {
                      showToast(context,
                          "الرقم غير موجود، تحقق من الرقم أو سجل حساباً جديداً");
                    } else if (state is ForgetPassCodeSentState) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                  value: forgetPassCubit,
                                  child: RestorePassOtpScreen(
                                      forgetPassCubit: forgetPassCubit,
                                      verificationId: state.verId,
                                      userModel: state.user),
                                )),
                        (Route<dynamic> route) => false,
                      );
                    }
                  }, builder: (context, state) {
                    ForgetPassCubit forgetPassCubit =
                        ForgetPassCubit.get(context);
                    if (state is ForgetPassLoadingState) {
                      return const LoadingWidget();
                    } else {
                      return CustomButton(
                          text: "استرجاع",
                          onTap: () {
                            if (restorePasswordFormKey.currentState!
                                .validate()) {
                              forgetPassCubit
                                  .checkPhoneExist(phoneController.text);
                            }
                          });
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
