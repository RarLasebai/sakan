import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';

class OnStackIcon extends StatelessWidget {
  final bool isFav;
  const OnStackIcon({super.key, required this.isFav});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 8.0, right: 16, left: 16),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    isFav ? softRed.withOpacity(1) : darkGrey.withOpacity(.5)),
            color: isFav ? softRed.withOpacity(.42) : softGrey.withOpacity(.42),
            borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            isFav ? Icons.favorite : Icons.arrow_back_ios_new,
            color: isFav ? darkRed : darkGrey.withOpacity(.5),
            size: 20,
          ),
        ),
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(
    //       color: softRed, borderRadius: BorderRadius.circular(15.r)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8),
    //     child: Icon(
    //       isFav ?
    //       Icons.favorite :
    //       Icons.arrow_back_ios_new,
    //       color:
    //       isFav ?
    //        darkRed : Colors.white,
    //     ),
    //   ),
    // );
  }
}
