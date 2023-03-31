import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_snack_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_cubit.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_states.dart';
import 'package:sakan/features/auth/presentation/screens/login_screen.dart';
import 'package:sakan/features/auth/presentation/screens/otp_verfication_screen.dart';

class SignUpOneScreen extends StatelessWidget {
  const SignUpOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController personalProofController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    GlobalKey<FormState> signUpOneFormKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        body: Form(
          key: signUpOneFormKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 11,
                right: 24,
                left: 24,
              ),
              child: ListView(
                children: [
                  Image.asset("assets/images/demo.png"),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 16),
                    child: Center(
                      child: TxtStyle(
                          "إنشاء حساب جديد", 18, Colors.black, FontWeight.bold),
                    ),
                  ),
                  //text fields
                  CustomTextField(
                    hint: "الاسم",
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك لا تترك الحقل فارغاً";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomTextField(
                      hint: "رقم الهاتف",
                      controller: phoneController,
                      isNumbers: true,
                      isPhone: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك لا تترك الحقل فارغاً";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  CustomTextField(
                    hint: "إثبات شخصي",
                    controller: personalProofController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك لا تترك الحقل فارغاً";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomTextField(
                      isPass: true,
                      hint: "كلمة المرور",
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك لا تترك الحقل فارغاً";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  CustomTextField(
                    isPass: true,
                    hint: "تأكيد كلمة المرور",
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك لا تترك الحقل فارغاً";
                      } else if (value != passwordController.text) {
                        return "كلمة المرور غير متطابقة";
                      } else {
                        return null;
                      }
                    },
                  ),

                  //buttons

                  BlocConsumer<SignupCubit, SignupStates>(
                      listener: (context, signupState) {
                    SignupCubit signupCubit = SignupCubit.get(context);

                    if (signupState is CodeSentSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                value: signupCubit,
                                child: OtpVerficationScreen(
                                  signupCubit: signupCubit,
                                  verificationId: signupState.verificationId,
                                  phoneNumber: phoneController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                  personalProof: personalProofController.text,
                                ))),
                      );
                    } else if (signupState is SignupErrorState) {
                      showSnackBar(context, signupState.message);
                    }
                  }, builder: (context, signupState) {
                    SignupCubit signupCubit = SignupCubit.get(context);

                    if (signupState is SignupLoadingState) {
                      return const LoadingWidget();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 16),
                        child: CustomButton(
                            text: "التالي",
                            onTap: () {
                              if (signUpOneFormKey.currentState!.validate()) {
                                signupCubit.verfiyPhone(
                                    phone: phoneController.text.trim(),
                                    context: context);
                              }
                            }),
                      );
                    }
                  }),

                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TxtStyle("لديك حساب بالفعل؟", 12, darkGrey,
                              FontWeight.normal),
                          SizedBox(
                            width: 6.w,
                          ),
                          const TxtStyle(
                              "الدخول", 12, Colors.black, FontWeight.normal),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
