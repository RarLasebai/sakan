// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/call_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/presentation/screens/details_screen.dart';

class HouseWidget extends StatelessWidget {
  const HouseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: secondaryGrey, borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 320.w,
                height: 172.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/room.png")),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TxtStyle(
                      "نوع السكن - المنطقة", 16, Colors.black, FontWeight.bold),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primary,
                      ),
                      TxtStyle("الموقع", 12, darkGrey, FontWeight.normal),
                    ],
                  ),

                  //cost and call
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    child: SizedBox(
                      width: 300.w,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //cost
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TxtStyle(
                                  "السعر", 12, darkGrey, FontWeight.normal),
                              TxtStyle("12000 LYD", 16, Colors.black,
                                  FontWeight.bold),
                            ],
                          ),
                          //call icon
                          CallWidget()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
