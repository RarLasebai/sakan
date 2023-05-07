import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/empty_data_widget.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_states.dart';
import 'package:sakan/features/favorite/application/favoriteCubit/favorite_cubit.dart';
import 'package:sakan/features/favorite/application/favoriteCubit/favorite_states.dart';
import 'package:sakan/features/favorite/presentation/widgets/favorite_house_widget.dart';
import 'package:sakan/features/home/presentation/screens/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthGetUser) {
            return SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TxtStyle("المساكن المفضلة لديك", 18,
                            Colors.black, FontWeight.bold),
                      ),
                      BlocProvider(
                        create: (context) =>
                            FavoriteCubit()..getFavoriteHouses(),
                        child: BlocConsumer<FavoriteCubit, FavoriteStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              FavoriteCubit favoriteCubit =
                                  FavoriteCubit.get(context);
                              if (state is FavoriteHousesEmptyState) {
                                return const Center(
                                  child: EmptyDataWidget(
                                      message: "ليس لديك مساكن مفضلة بعد!"),
                                );
                              } else if (state is FavoriteHousesLoadedState) {
                                return Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(children: [
                                      ...state.houses
                                          .map((house) => GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailsScreen(
                                                                houseModel:
                                                                    house))).then(
                                                    (value) => favoriteCubit
                                                        .getFavoriteHouses());
                                              },
                                              child: FavoriteHouseWidget(
                                                  houseModel: house)))
                                          .toList()
                                    ]),
                                  ),
                                );
                              } else {
                                return const LoadingWidget();
                              }
                            }),
                      ),
                    ],
                  )),
            );
          } else if (state is AuthErrorState) {
            return Center(
                child:
                    TxtStyle(state.message, 16, darkGrey, FontWeight.normal));
          } else {
            return const LoadingWidget();
          }
        });
  }
}
