import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/on_stack_icon.dart';
import 'package:sakan/features/home/presentation/screens/house_image_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HouseSlider extends StatefulWidget {
  final List imgList;
  const HouseSlider({required this.imgList, super.key});

  @override
  State<HouseSlider> createState() => _HouseSliderState();
}

class _HouseSliderState extends State<HouseSlider> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.imgList.length,
              itemBuilder: (context, index, realIndex) {
                final image = widget.imgList[index];
                return Stack(
                  children: [
                    //image
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HouseImageScreen(image: image)));
                      },
                      child: Container(
                        height: 278.h,
                        width: MediaQuery.of(context).size.width.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(image),
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
                  count: widget.imgList.length,
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
