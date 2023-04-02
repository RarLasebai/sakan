import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/screens/home_layout.dart';

import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/login_cubit/login_cubit.dart';
import 'package:sakan/features/auth/application/login_cubit/login_states.dart';
import 'package:sakan/features/auth/presentation/screens/restore_password_screen.dart';
import 'package:sakan/features/auth/presentation/screens/sign_up_one_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: loginFormKey,
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
                  Image.asset("assets/images/demo.png"),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 16),
                    child: Center(
                      child: TxtStyle(
                          "تسجيل الدخول", 18, Colors.black, FontWeight.bold),
                    ),
                  ),
                  CustomTextField(
                    hint: "رقم الهاتف",
                    isPhone: true,
                    isNumbers: true,
                    controller: phoneController,
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
                      hint: "كلمة المرور",
                      isPass: true,
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
                  BlocConsumer<LoginCubit, LoginStates>(
                      listener: (context, state) {
                    if (state is LoginSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeLayout(
                                    userModel: state.user,
                                  )),
                          (Route<dynamic> route) => false);
                    } else if (state is UserNotFoundState) {
                      showToast(context,
                          "رقم الهاتف أو كلمة المرور غير صحيحة، تحقق مجدداً.");
                    }
                  }, builder: (context, state) {
                    LoginCubit loginCubit = LoginCubit.get(context);

                    if (state is LoginLoadingState) {
                      return const LoadingWidget();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CustomButton(
                            text: "تسجيل الدخول",
                            onTap: () {
                              if (loginFormKey.currentState!.validate()) {
                                loginCubit.login(
                                    phone: phoneController.text,
                                    pass: passwordController.text);
                              }
                            }),
                      );
                    }
                  }),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RestorePasswordScreen()),
                      );
                    },
                    child: const TxtStyle("نسيت كلمة المرور؟", 12, Colors.black,
                        FontWeight.normal,
                        textDecoration: TextDecoration.underline),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpOneScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TxtStyle("ليس لديك حساب؟", 12, darkGrey,
                              FontWeight.normal),
                          SizedBox(
                            width: 6.w,
                          ),
                          const TxtStyle(
                              "التسجيل", 12, Colors.black, FontWeight.normal),
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
