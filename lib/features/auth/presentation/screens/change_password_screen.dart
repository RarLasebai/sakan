import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/splash_and_boarding/presentation/screens/splash_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: changePasswordFormKey,
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
                    child: TxtStyle("إعادة تعيين كلمة المرور", 18, Colors.black,
                        FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 20),
                  child: CustomTextField(
                    hint: "كلمة المرور",
                    isPhone: true,
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
                  hint: "تأكيد كلمة المرور",
                  isPhone: true,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "من فضلك لا تترك الحقل فارغاً";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 28.h,
                ),
                CustomButton(
                    text: "حفظ",
                    onTap: () {
                      // if (signUpOneFormKey.currentState!.validate()) {}
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                          (Route<dynamic> route) => false);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
