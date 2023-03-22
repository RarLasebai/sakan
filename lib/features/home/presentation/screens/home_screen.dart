import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/presentation/screens/search_screen.dart';
import 'package:sakan/features/home/presentation/screens/view_more_screen.dart';
import 'package:sakan/features/home/presentation/widgets/house_widget.dart';
import 'package:sakan/features/home/presentation/widgets/search_button_widget.dart';

import '../widgets/ads_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            // physics: const AlwaysScrollableScrollPhysics(
            //     parent: BouncingScrollPhysics()),
            child: Column(children: [
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TxtStyle(
                          "مرحباً بك!", 22, Colors.black, FontWeight.normal),
                      TxtStyle(
                        "تفقد آخر عروضنا المضافة..",
                        14,
                        darkGrey,
                        FontWeight.normal,
                        longText: true,
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                      },
                      child: const SearchButtonWidget())
                ],
              ),

              //ads
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: AdsSlider(),
              ),

              //Last Houses Added header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TxtStyle(
                      "آخر المساكن المضافة", 18, Colors.black, FontWeight.bold),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewMoreScreen()));
                      },
                      child: const TxtStyle(
                        "عرض المزيد",
                        13,
                        darkGrey,
                        FontWeight.normal,
                        textDecoration: TextDecoration.underline,
                      ))
                ],
              ),
              //Last Houses Added widget
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const HouseWidget(),
                    SizedBox(
                      width: 10.w,
                    ),
                    const HouseWidget(),
                    SizedBox(
                      width: 10.w,
                    ),
                    const HouseWidget(),
                  ],
                ),
              ),

              SizedBox(
                height: 7.h,
              )
            ]),
          )),
    );
  }
}
