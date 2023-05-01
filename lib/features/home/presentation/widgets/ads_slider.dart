// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/features/home/application/bannersCubit/banners_cubit.dart';
import 'package:sakan/features/home/application/bannersCubit/banners_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdsSlider extends StatelessWidget {
  const AdsSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BannersCubit()..getAdsImages();
      },
      child: BlocConsumer<BannersCubit, BannersStates>(
          listener: ((context, state) {}),
          builder: (context, bannerState) {
            BannersCubit bannersCubit = BannersCubit.get(context);
            return ConditionalBuilder(
                condition: bannerState is! BannersLoadingState,
                builder: (context) {
                  return Center(
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: bannersCubit.imgList.length,
                          itemBuilder: (context, index, realIndex) {
                            final image = bannersCubit.imgList[index];
                            return Image(image: AssetImage(image));
                          },
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              bannersCubit.bannerChanges(index);
                            },
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 2),
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
                              activeIndex: bannersCubit.currentIndex,
                              count: bannersCubit.imgList.length,
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
                  );
                },
                fallback: (context) => LoadingWidget());
          }),
    );
  }
}
