import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/screens/home_layout.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/widgets/radio_button_widget.dart';

class SignUpTwoScreen extends StatelessWidget {
  const SignUpTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController();
    TextEditingController nationalityController = TextEditingController();

    GlobalKey<FormState> signUpTwoFormKey = GlobalKey<FormState>();

    String groupValue = "أعزب";

    return Scaffold(
      body: Form(
        key: signUpTwoFormKey,
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
                        "أكمل تسجيل حسابك", 18, Colors.black, FontWeight.bold),
                  ),
                ),
                CustomTextField(
                  hint: "المنطقة",
                  controller: cityController,
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
                    hint: "الجنسية",
                    controller: nationalityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك لا تترك الحقل فارغاً";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const TxtStyle(
                      "الحالة الإجتماعية", 12, darkGrey, FontWeight.normal),
                  CustomRadioButton(groupValue: groupValue, title: "أعزب"),
                  CustomRadioButton(groupValue: groupValue, title: "متزوج"),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 16),
                  child: CustomButton(
                      text: "تسجيل",
                      onTap: () {
                        // if (signUpOneFormKey.currentState!.validate()) {}
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeLayout()),
                            (Route<dynamic> route) => false);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
