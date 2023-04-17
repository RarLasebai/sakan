import 'package:flutter/material.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/presentation/screens/details_screen.dart';
import 'package:sakan/features/profile/application/profile_cubit/profile_cubit.dart';
import 'package:sakan/features/profile/application/profile_cubit/profile_states.dart';
import 'package:sakan/features/profile/presentation/widgets/my_house_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHousesScreen extends StatelessWidget {
  final ProfileCubit profileCubit;

  const MyHousesScreen({required this.profileCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // value: ProfileCubit()..getMyHouses(),
      value: BlocProvider.of<ProfileCubit>(context)..getMyHouses(),
      child: Scaffold(
        appBar: TopNavBar("عروضي"),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const LoadingWidget();
                } else if (state is HousesIsEmptyState) {
                  return const Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TxtStyle("ليس لديك عروض بعد! ", 16, Colors.grey,
                              FontWeight.w500,
                              longText: true, textAlignm: TextAlign.center),
                          TxtStyle(
                              "إبدأ الآن واملأ نموذجاً لسكنك،\nواعثر على مستأجرين بشكل أسرع!",
                              16,
                              Colors.grey,
                              FontWeight.w500,
                              longText: true,
                              textAlignm: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                } else if (state is MyHousesLoadedState) {
                  if (state.houses.isEmpty) {
                    return const Center(
                        child: TxtStyle(
                            "أعثر على مستأجرين بشكل أسرع! \n قم بتقديم نموذج للسكن الذي تودُّ عرضه للإيجار!",
                            16,
                            Colors.grey,
                            FontWeight.w500,
                            textAlignm: TextAlign.center));
                  } else {
                    return SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(19),
                      child: Column(
                        children: [
                          ...state.houses
                              .map((house) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                      houseModel: house)));
                                    },
                                    child: MyHouseWidget(
                                      houseModel: house,
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
                    ));
                  }
                } else {
                  return const Center(
                      child: TxtStyle(
                          "هنا تعرض المساكن الخاصة بك التي عرضتها للإيجار!",
                          14,
                          Colors.black,
                          FontWeight.normal,
                          longText: true));
                }
              }),
        ),
      ),
    );
  }
}
