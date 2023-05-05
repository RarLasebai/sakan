import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class PropsWidget extends StatelessWidget {
  final String title, icon, subTitle;
  const PropsWidget(
      {required this.title,
      required this.subTitle,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 129.w,
        height: 139.h,
        decoration: BoxDecoration(
            border: Border.all(color: primary, width: 1.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 10, 13, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/icons/$icon.png")),
              TxtStyle(
                title,
                12,
                darkGrey,
                FontWeight.bold,
                textAlignm: TextAlign.center,
              ),
              TxtStyle(subTitle, 14, Colors.black, FontWeight.bold),
            ],
          ),
        ));
  }
}
