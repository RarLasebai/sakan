import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class RoomsCountTextField extends StatelessWidget {
 final TextEditingController roomsController;
 final TextEditingController kitchenController;
 final TextEditingController toiletController;
  const RoomsCountTextField({required this.kitchenController, required this.roomsController, required this.toiletController, super.key});

  @override
  Widget build(BuildContext context) {
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
                  controller: roomsController,
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
                  controller: toiletController,
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
                  controller: kitchenController,
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
