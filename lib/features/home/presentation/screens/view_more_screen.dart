import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/application/homeCubit/home_cubit.dart';
import 'package:sakan/features/home/presentation/screens/details_screen.dart';
import 'package:sakan/features/home/presentation/widgets/house_type_widget.dart';
import 'package:sakan/features/home/presentation/widgets/house_widget.dart';

import '../../application/homeCubit/home_states.dart';

class ViewMoreScreen extends StatelessWidget {
  const ViewMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar("كل العروض"),
      body: BlocProvider(
        create: (context) => HomeCubit()..getHouseWithType("شقة"),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  HomeCubit homeCubit = HomeCubit.get(context);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 25),
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 46.h,
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeCubit.houseTypes.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {
                                            if (homeCubit.selectedIndex ==
                                                index) {
                                              homeCubit.selectedIndex = null;
                                            } else {
                                              homeCubit.selectedIndex = index;
                                            }
                                            homeCubit.houseImageChanges(index);
                                            homeCubit.getHouseWithType(
                                                homeCubit.houseTypes[index]);
                                          },
                                          child: HouseTypeWidget(
                                              isSelected:
                                                  homeCubit.selectedIndex ==
                                                          index
                                                      ? true
                                                      : false,
                                              title:
                                                  homeCubit.houseTypes[index]),
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<HomeCubit, HomeStates>(
                          builder: (context, homeState) {
                        if (homeState is HouseWithTypeLoadedState) {
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...homeState.houses
                                      .map((house) => GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsScreen(
                                                            houseModel:
                                                                house)));
                                          },
                                          child:
                                              HouseWidget(houseModel: house)))
                                      .toList()
                                ],
                              ),
                            ),
                          );
                        } else if (homeState is HouseWithTypeLoadingState) {
                          return const Center(child: LoadingWidget());
                        } else if (homeState is NoHousesInThisTypeState) {
                          return Center(
                            child: TxtStyle(
                              homeState.message,
                              15,
                              darkGrey,
                              FontWeight.normal,
                              longText: true,
                            ),
                          );
                        } else {
                          return const Center(
                            child: TxtStyle("اختر الفئة التي تناسبك!", 15,
                                darkGrey, FontWeight.normal),
                          );
                        }
                      }),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
