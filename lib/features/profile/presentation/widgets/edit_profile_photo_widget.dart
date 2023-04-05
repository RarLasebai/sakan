
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';

class EditProfilePhotoWidget extends StatelessWidget {
  final void Function() onTap;
  final String image;
  const EditProfilePhotoWidget(
      {required this.onTap, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 110.w,
            height: 110.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 15.0.r,
              backgroundColor: primary,
              child: const Icon(
                Icons.photo_camera,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
