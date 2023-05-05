import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';

class FieldWidget extends StatelessWidget {
  final String icon, hint;
  final bool isPrice, isDesc, isLocation;
  final TextEditingController controller;
  const FieldWidget(
      {super.key,
      required this.hint,
      required this.icon,
      required this.controller,
      this.isDesc = false,
      this.isPrice = false,
      this.isLocation = false});

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
              child: hint == "أقل مدة للإيجار"
                  ? const Icon(
                      Icons.calendar_month_sharp,
                      color: Colors.brown,
                    )
                  : Image(image: AssetImage("assets/icons/$icon"))),
        ),
        Expanded(
          child: CustomTextField(
              isLocation: isLocation,
              isPrice: isPrice,
              isDesc: isDesc,
              hint: hint,
              controller: controller,
              validator: (validator) {
                if (validator == null || validator.isEmpty) {
                  return "لا تترك الحقل فارغاً";
                } else {
                  return null;
                }
              }),
        )
      ],
    );
  }
}
