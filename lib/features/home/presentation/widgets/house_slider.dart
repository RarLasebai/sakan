import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/on_stack_icon.dart';
import 'package:sakan/features/home/presentation/screens/house_image_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HouseSlider extends StatefulWidget {
  const HouseSlider({super.key});

  @override
  State<HouseSlider> createState() => _HouseSliderState();
}

class _HouseSliderState extends State<HouseSlider> {
  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      "assets/images/room.png",
      "assets/images/boarding3.png",
      "assets/images/boarding2.png",
      "assets/images/boarding1.png",
    ];
    int currentIndex = 0;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: imgList.length,
              itemBuilder: (context, index, realIndex) {
                final image = imgList[index];
                return Stack(
                  children: [
                    //image
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HouseImageScreen()));
                      },
                      child: Container(
                        height: 278.h,
                        width: MediaQuery.of(context).size.width.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(image),
                          ),
                        ),
                      ),
                    ),
                    //fav and back
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const OnStackIcon(isFav: true),
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const OnStackIcon(isFav: false))
                      ],
                    )
                  ],
                );
              },
              options: CarouselOptions(
                height: 278.h,

                onPageChanged: (index, reason) {
                  //  bannersCubit.bannerChanges(index);
                  setState(() {
                    currentIndex = index;
                  });
                },
                // autoPlay: true,
                // autoPlayInterval: const Duration(seconds: 2),
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayCurve: Curves.easeIn,
                viewportFraction: 1,
                aspectRatio: 2.0,
                initialPage: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 15),
              child: AnimatedSmoothIndicator(
                  activeIndex: currentIndex,
                  count: imgList.length,
                  effect: const ScrollingDotsEffect(
                    radius: 8,
                    spacing: 8,
                    dotHeight: 11,
                    dotWidth: 11,
                    dotColor: softRed,
                    activeDotColor: primary,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
