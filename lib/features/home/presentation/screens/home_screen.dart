import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/presentation/screens/details_screen.dart';
import 'package:sakan/features/home/presentation/screens/search_screen.dart';
import 'package:sakan/features/home/presentation/screens/view_more_screen.dart';
import 'package:sakan/features/home/presentation/widgets/house_widget.dart';
import 'package:sakan/features/home/presentation/widgets/search_button_widget.dart';

import '../../application/homeCubit/home_cubit.dart';
import '../../application/homeCubit/home_states.dart';
import '../widgets/ads_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
    
            child: Column(children: [
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

              //ads - banners - slider OR Whatever!!!!
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
              BlocProvider(
                create: (context) => HomeCubit()..getLatestHouses(),
                child: BlocConsumer<HomeCubit, HomeStates>(
                    listener: (context, state) {},
                    builder: (context, homeState) {
                      if (homeState is HomeLoadingState) {
                        return const LoadingWidget();
                      } else if (homeState is LatestHousesLoadedState) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...homeState.houses
                                  .map((house) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreen(
                                                        houseModel: house)));
                                      },
                                      child: HouseWidget(houseModel: house)))
                                  .toList()
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                            child: TxtStyle("حدث خطأ في تحميل المساكن", 12,
                                Colors.red, FontWeight.bold));
                      }
                    }),
              ),
            ]),
          )),
    );
  }
}
