// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/screens/sign_up_two_screen.dart';

class OtpVerficationScreen extends StatelessWidget {
  const OtpVerficationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OtpFieldController otpController = OtpFieldController();

    GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                const TxtStyle(
                  "لقد أرسلنا رمز التأكيد إلى 09111111111 يرجى إدخاله",
                  12,
                  darkGrey,
                  FontWeight.normal,
                  longText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: SizedBox(
                      height: 69.h,
                      child: OTPTextField(
                          controller: otpController,
                          length: 4,
                          width: MediaQuery.of(context).size.width.sp,
                          textFieldAlignment: MainAxisAlignment.spaceEvenly,
                          fieldWidth: 69.w,
                          fieldStyle: FieldStyle.underline,
                          outlineBorderRadius: 15,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: 'Changa',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (pin) {
                            print("Changed: $pin");
                          },
                          onCompleted: (pin) {
                            print("Completed: $pin");
                          }),
                    ),
                  ),
                ),
                CustomButton(
                    text: "استمرار",
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpTwoScreen()),
                          (Route<dynamic> route) => false);
                    }),
                SizedBox(
                  height: 7.h,
                ),
                const TxtStyle(
                  "إعادة إرسال الرمز؟",
                  12,
                  Colors.black,
                  FontWeight.normal,
                  textDecoration: TextDecoration.underline,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
