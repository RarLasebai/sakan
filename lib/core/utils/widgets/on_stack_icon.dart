import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/features/home/application/homeCubit/home_cubit.dart';
import 'package:sakan/features/home/application/homeCubit/home_states.dart';

class OnStackIcon extends StatelessWidget {
  final bool isFav, isFavScreen;
  final HomeCubit? homeCubit;
  const OnStackIcon(
      {super.key,
      this.homeCubit,
      this.isFavScreen = false,
      required this.isFav});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
        return Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.only(top: 8.0, right: 16, left: 16),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: isFav
                        ? softRed.withOpacity(1)
                        : darkGrey.withOpacity(.5)),
                color: isFav
                    ? softRed.withOpacity(.42)
                    : softGrey.withOpacity(.42),
                borderRadius: BorderRadius.circular(15.r)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: isFavScreen
                  ? Icon(
                      isFav ? Icons.favorite : Icons.arrow_back_ios_new,
                      color: isFav ? primary : Colors.black54,
                      size: 20,
                    )
                  : Icon(
                      isFav ? Icons.favorite : Icons.arrow_back_ios_new,
                      color: isFav ? homeCubit!.fav : Colors.black54,
                      size: 20,
                    ),
            ),
          ),
        );
      }),
    );

  }
}
