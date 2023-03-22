import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/screens/sign_up_one_screen.dart';
import 'package:sakan/features/splash_and_boarding/domain/entities/boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardItemWidget extends StatelessWidget {
  final BoardingModel boardingModel;
  final int index, length;
  final PageController pageController;
  const BoardItemWidget(
      {super.key,
      required this.boardingModel,
      required this.index,
      required this.pageController,
      required this.length});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 46,
            right: 305,
            bottom: 50,
          ),
          child: index == 2
              ? SizedBox(
                  height: 20.h,
                )
              : GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpOneScreen()),
                      (Route<dynamic> route) => false),
                  child: const TxtStyle(
                    "تخطي",
                    13,
                    darkRed,
                    FontWeight.normal,
                    longText: true,
                    textAlignm: TextAlign.center,
                  ),
                ),
        ),
        Image.asset(
          boardingModel.image,
          width: 412.w,
          height: 292.h,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 21, bottom: 43),
          child: SmoothPageIndicator(
              controller: pageController,
              count: length,
              effect: const WormEffect(
                radius: 8,
                spacing: 8,
                dotHeight: 11,
                dotWidth: 11,
                dotColor: softRed,
                activeDotColor: primary,
              )),
        ),
        TxtStyle(
          boardingModel.title,
          24,
          darkRed,
          FontWeight.bold,
        ),
        TxtStyle(
          boardingModel.description,
          18,
          darkGrey,
          FontWeight.normal,
          longText: true,
          textAlignm: TextAlign.center,
        ),
      ],
    );
  }
}
