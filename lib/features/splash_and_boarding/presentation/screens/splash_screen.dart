import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/splash_and_boarding/presentation/screens/boarding_screen.dart';

import '../../../../core/utils/colors/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BoardingScreen()),
                      (Route<dynamic> route) => false,
                    ),
                    child: Image.asset(
                      "assets/images/logo.png",
                      color: darkGrey,
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            const TxtStyle("سكن", 25, Colors.white, FontWeight.bold),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
