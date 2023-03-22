import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';

class FieldWidget extends StatelessWidget {
  final String icon, hint;
  final TextEditingController controller;
  const FieldWidget(
      {super.key,
      required this.hint,
      required this.icon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                  color: const Color(0xffFFEEEA),
                  borderRadius: BorderRadius.circular(15.r)),
              child: Image(image: AssetImage("assets/icons/$icon"))),
        ),
        Expanded(
          child: CustomTextField(
              hint: hint,
              controller: controller,
              validator: (validator) {
                return null;
              }),
        )
      ],
    );
  }
}
