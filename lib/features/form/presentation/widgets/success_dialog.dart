import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: Container(
          height: 189.h,
          decoration: BoxDecoration(
              border: Border.all(color: primary, width: 1.5),
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/success.png",
              ),
              SizedBox(height: 33.h),
              const TxtStyle(
                  "تم إرسال النموذج", 18, Colors.black, FontWeight.bold),
              const TxtStyle(
                "سيتواصل معك مندوب المكتب قريباً",
                12,
                darkGrey,
                FontWeight.normal,
                longText: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
