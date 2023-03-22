import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class ProfileListTileWidget extends StatelessWidget {
  final String icon, title;
  final VoidCallback? onTap;
  final bool onPress;
  const ProfileListTileWidget(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.onPress = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: ListTile(
        title: TxtStyle(title, 14, Colors.black, FontWeight.normal),
        onTap: onTap,
        leading: Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                color: const Color(0xffFFEEEA),
                borderRadius: BorderRadius.circular(15.r)),
            child: Image(image: AssetImage("assets/icons/$icon"))),
        trailing: onPress == true
            ? Container(
                decoration: BoxDecoration(
                    // color: primary,
                    border: Border.all(color: darkGrey, width: 1.w),
                    borderRadius: BorderRadius.circular(35.r)),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 13,
                  ),
                ))
            : const SizedBox(),
      ),
    );
  }
}
