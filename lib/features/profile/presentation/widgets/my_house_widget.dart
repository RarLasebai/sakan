import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/call_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class MyHouseWidget extends StatelessWidget {
  final String status;
  const MyHouseWidget({super.key, required this.status});

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: const Image(
                  image: AssetImage("assets/images/room.png"),
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
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: primary,
                      ),
                      TxtStyle("الموقع", 12, darkGrey, FontWeight.normal),
                    ],
                  ),

                  //cost
                  Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 12),
                      child:
                          //cost
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          TxtStyle("السعر", 12, darkGrey, FontWeight.normal),
                          TxtStyle(
                              "12000 LYD", 16, Colors.black, FontWeight.bold),
                        ],
                      )),
                  Row(
                    children: [
                      const TxtStyle(
                          "حالة الطلب:  ", 14, primary, FontWeight.w800),
                      TxtStyle(status, 14, Colors.black, FontWeight.w800),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 50.h,
                      child: const CallWidget(
                        isPink: true,
                        isEdit: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
