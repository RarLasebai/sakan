import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/favorite/presentation/widgets/favorite_house_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TxtStyle(
                    "المساكن المفضلة لديك", 18, Colors.black, FontWeight.bold),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    const FavoriteHouseWidget(),
                    SizedBox(
                      height: 10.w,
                    ),
                    const FavoriteHouseWidget(),
                    SizedBox(
                      height: 10.w,
                    ),
                    const FavoriteHouseWidget(),
                    SizedBox(
                      height: 7.h,
                    )
                  ]),
                ),
              ),
            ],
          )),
    );
  }
}
