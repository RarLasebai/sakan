import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/screens/home_layout.dart';

import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/foget_pass_states.dart';
import 'package:sakan/features/auth/application/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ForgetPassCubit forgetPassCubit;
  final UserModel userModel;
  const ChangePasswordScreen(
      {required this.forgetPassCubit, required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ForgetPassCubit>(context),
      child: BlocConsumer<ForgetPassCubit, ForgetPassStates>(
          listener: (context, state) {
        ForgetPassCubit forgetPassCubit = ForgetPassCubit.get(context);
        if (state is PasswordChangedSuccessState) {
          showToast(context, "تم حفظ كلمة المرور الجديدة", color: Colors.green);
          forgetPassCubit.setSignin();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeLayout(
                        userModel: userModel,
                      )),
              (Route<dynamic> route) => false);
        }
      }, builder: (context, state) {
        ForgetPassCubit forgetPassCubit = ForgetPassCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Form(
            key: forgetPassCubit.changePasswordFormKey,
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
                        child: TxtStyle("إعادة تعيين كلمة المرور", 18,
                            Colors.black, FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 20),
                      child: CustomTextField(
                        hint: "كلمة المرور",
                        isPassField: true,
                        isPass: forgetPassCubit.isPassword,
                        suffixIcon: forgetPassCubit.suffixIcon,
                        suffixOnTap: forgetPassCubit.changePassVisibilty,
                        controller: forgetPassCubit.passwordController,
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
                      hint: "تأكيد كلمة المرور",
                      isPassField: true,
                      isPass: forgetPassCubit.isPassword,
                      suffixIcon: forgetPassCubit.suffixIcon,
                      suffixOnTap: forgetPassCubit.changePassVisibilty,
                      controller: forgetPassCubit.confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك لا تترك الحقل فارغاً";
                        } else if (forgetPassCubit.passwordController.text !=
                            forgetPassCubit.confirmPasswordController.text) {
                          return "كلمة المرور غير متطابقة";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    ConditionalBuilder(
                        condition: state is! ForgetPassLoadingState,
                        fallback: (context) => const LoadingWidget(),
                        builder: (context) {
                          return CustomButton(
                              text: "حفظ",
                              onTap: () {
                                if (forgetPassCubit
                                    .changePasswordFormKey.currentState!
                                    .validate()) {
                                  forgetPassCubit.changePass(
                                      userModel: userModel,
                                      pass: forgetPassCubit
                                          .passwordController.text);
                                }
                              });
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
