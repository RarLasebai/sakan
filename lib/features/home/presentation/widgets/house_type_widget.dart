import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class HouseTypeWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  const HouseTypeWidget(
      {super.key, required this.isSelected, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
            color: isSelected ? primary : Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: isSelected ? Colors.white : primary)),
        child: Center(
            child: TxtStyle(title, 16, isSelected ? Colors.white : primary,
                FontWeight.normal)),
      ),
    );
  }
}
