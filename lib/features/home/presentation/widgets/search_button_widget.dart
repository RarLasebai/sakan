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
            child: Icon(
              Icons.filter_alt_outlined,
              color: Colors.white,
            )));
  }
}
