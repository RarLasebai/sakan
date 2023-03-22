import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: primary,
      ),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: ImageIcon(
          AssetImage(
            "assets/icons/search.png",
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
