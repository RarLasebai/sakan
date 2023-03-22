import 'package:flutter/material.dart';

import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/screens/change_password_screen.dart';

class RestorePasswordScreen extends StatelessWidget {
  final bool isProfile;
  const RestorePasswordScreen({super.key, this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();

    GlobalKey<FormState> restorePasswordFormKey = GlobalKey<FormState>();

    return Scaffold(
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
                Image.asset("assets/images/demo.png"),
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
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك لا تترك الحقل فارغاً";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                CustomButton(
                    text: "استرجاع",
                    onTap: () {
                      // if (signUpOneFormKey.currentState!.validate()) {}
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordScreen()),
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
