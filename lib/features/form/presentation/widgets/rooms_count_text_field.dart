import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class RoomsCountTextField extends StatelessWidget {
  const RoomsCountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController c = TextEditingController();
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.meeting_room_sharp,
                  color: Colors.orange,
                ),
                TxtStyle("  عدد الغرف", 12, Colors.black, FontWeight.normal),
              ],
            ),
            SizedBox(
              width: 150.w,
              height: 80.h,
              child: CustomTextField(
                  hint: "",
                  controller: c,
                  isPrice: true,
                  validator: (validator) {
                    if (validator == null || validator.isEmpty) {
                      return "لا تترك الحقل فارغاً";
                    } else {
                      return null;
                    }
                  }),
            )
          ],
        ),

        // حمامات
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.shower_rounded,
                  color: Colors.orange,
                ),
                TxtStyle("  عدد الحمامات", 12, Colors.black, FontWeight.normal),
              ],
            ),
            SizedBox(
              width: 150.w,
              height: 80.h,
              child: CustomTextField(
                  hint: "",
                  controller: c,
                  isPrice: true,
                  validator: (validator) {
                    if (validator == null || validator.isEmpty) {
                      return "لا تترك الحقل فارغاً";
                    } else {
                      return null;
                    }
                  }),
            )
          ],
        ),

        //مطابخ
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.countertops_outlined,
                  color: Colors.orange,
                ),
                TxtStyle("  عدد المطابخ", 12, Colors.black, FontWeight.normal),
              ],
            ),
            SizedBox(
              width: 150.w,
              height: 80.h,
              child: CustomTextField(
                  hint: "",
                  controller: c,
                  isPrice: true,
                  validator: (validator) {
                    if (validator == null || validator.isEmpty) {
                      return "لا تترك الحقل فارغاً";
                    } else {
                      return null;
                    }
                  }),
            )
          ],
        )
      ],
    );
  }
}
