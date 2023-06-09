// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/on_stack_icon.dart';
import 'package:sakan/features/home/application/homeCubit/home_cubit.dart';
import 'package:sakan/features/home/presentation/screens/house_image_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../application/homeCubit/home_states.dart';

class HouseSlider extends StatelessWidget {
  final List imgList;
  final String houseId;
  const HouseSlider({required this.imgList, required this.houseId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..checkHouseIsInFav(houseId),
      child: BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
  
      }, builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
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
                            GestureDetector(
                                onTap: () {
                                  homeCubit
                                      .addToFav(houseId)
                                      .then((value) => print("added to fav"));
                                  homeCubit.checkHouseIsInFav(houseId);
                                },
                                child: BlocProvider.value(
                                    value: homeCubit,
                                    child: ConditionalBuilder(
                                      condition:
                                          state is! AddHouseToFavLoadingState,
                                      fallback: (context) =>
                                          const CircularProgressIndicator(
                                              color: primary),
                                      builder: (context) => OnStackIcon(
                                        isFav: true,
                                        homeCubit: homeCubit,
                                      ),
                                    ))),
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child:
                                    const OnStackIcon(isFav: false))
                          ],
                        )
                      ],
                    );
                  },
                  options: CarouselOptions(
                    height: 278.h,

                    onPageChanged: (index, reason) {
                      homeCubit.houseImageChanges(index);
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
                      activeIndex: homeCubit.currentIndex,
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
      }),
    );
  }
}
