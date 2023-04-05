import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar("تواصل معنا"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 314.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/boarding3.png"),
              ),
            ),
          ),
          const Column(
            children: [
              TxtStyle("تطبيق سكن", 18, Colors.black, FontWeight.normal),
              TxtStyle(
                '''
    التطبيق لا يزال قيد التطوير، ملاحظاتكم واقتراحاتكم 
    تهمنا!
    SAKAN@GMAIL.COM
    ''',
                14,
                darkGrey,
                FontWeight.normal,
                longText: true,
                isDescribtion: true,
                textAlignm: TextAlign.center,
              ),
            ],
          ),
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TxtStyle("POWERED BY:  ", 13, Colors.black, FontWeight.normal),
                TxtStyle(
                  "Sakan Company",
                  14,
                  darkGrey,
                  FontWeight.normal,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
