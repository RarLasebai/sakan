import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name, phone;
  final String image;
  const ProfileHeaderWidget(
      {required this.name,
      required this.phone,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 82.w,
            height: 71.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 18.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TxtStyle(name, 14, Colors.black, FontWeight.bold),
              TxtStyle(phone, 13, darkGrey, FontWeight.bold),
            ],
          )
        ],
      ),
    );
  }
}
