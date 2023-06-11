// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/functions/utils_functios.dart';

import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/foget_pass_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/auth/presentation/screens/restore_pass_otp_screen.dart';

import '../../application/forget_pass_cubit/forget_pass_cubit.dart';

class RestorePasswordScreen extends StatelessWidget {
  final bool isProfile;
  // final UserModel? userModel;
  const RestorePasswordScreen({super.key, this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();

    GlobalKey<FormState> restorePasswordFormKey = GlobalKey<FormState>();

    return BlocProvider.value(
      value: ForgetPassCubit()..getUser(),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: isProfile
                ? const TxtStyle("الإعدادات", 18, Colors.black, FontWeight.bold)
                : null,
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black)),
        // resizeToAvoidBottomInset: false,
        body: isProfile
            ? Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BlocBuilder<ForgetPassCubit, ForgetPassStates>(
                    builder: (context, state) {
                      ForgetPassCubit forgetPassCubit =
                          ForgetPassCubit.get(context);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              UserModel user = await getDataFromSharedPref();
                              if (user.userToken!.isEmpty) {
                                // forgetPassCubit.mtoken = t;
                                final token = await forgetPassCubit.getToken();
                                print("token ${token}");
                                //update user
                                forgetPassCubit
                                    .updateUserToken(
                                        userModel: user, userToken: token)
                                    .then((value) => showToast(
                                          context,
                                          "تم تفعيل الإشعارات",
                                          color: Colors.green,
                                        ))
                                    .then((value) => forgetPassCubit
                                        .notificationCheck = true);
                              } else {
                                forgetPassCubit
                                    .updateUserToken(
                                        userModel: user, userToken: "")
                                    .then((value) {
                                  showToast(context, "تم إلغاء تفعيل الإشعارات",
                                      color: Colors.amber);

                                  forgetPassCubit.mtoken = "";
                                  // forgetPassCubit.btnText = "تفعيل الإشعارات";
                                  forgetPassCubit.notificationCheck = false;
                                });
                                print("cancel notf");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  border: Border.all(
                                    color: darkGrey,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TxtStyle("تفعيل الإشعارات", 14, Colors.black,
                                      FontWeight.normal),
                                  Checkbox(
                                      activeColor: primary,
                                      value: forgetPassCubit.notificationCheck,
                                      onChanged: (context) => () {})
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                border: Border.all(
                                  color: darkGrey,
                                )),
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TxtStyle(
                                    "إعادة تعيين كلمة المرور",
                                    14,
                                    Colors.black,
                                    FontWeight.normal,
                                  ),
                                  SizedBox(width: 2)
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RestorePasswordScreen(
                                              isProfile: false,
                                            )));
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            : Form(
                // key: restorePasswordFormKey,
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
                            child: TxtStyle("استرجاع كلمة المرور", 18,
                                Colors.black, FontWeight.bold),
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
