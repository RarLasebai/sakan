import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

import '../colors/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final int width;
  const CustomButton({
    required this.text,
    required this.onTap,
    this.width = 327,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: primary,
        ),
        child: Center(
          child: TxtStyle(
            text,
            14,
            Colors.white,
            FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
