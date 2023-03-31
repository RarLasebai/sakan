import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sakan/core/utils/screens/home_layout.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_snack_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_states.dart';
import 'package:sakan/features/splash_and_boarding/presentation/screens/boarding_screen.dart';

import '../../../../core/utils/colors/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit()..checkSign(),
      child: Scaffold(
        backgroundColor: primary,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: SizedBox(
                    width: 150.w,
                    height: 150.h,
                    child: Image.asset(
                      "assets/images/logo.png",
                      color: darkGrey,
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const TxtStyle("سكن", 25, Colors.white, FontWeight.bold),
              SizedBox(
                height: 100.h,
              ),
               SizedBox(
              height: 100,
            ),
            SpinKitWanderingCubes(
              color: Colors.white,
              size: 50,
            ),
              BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, authState) {
                if (authState is AuthSuccessState) {
                  Timer(
                     const Duration(seconds: 7),
                      () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeLayout(userModel: authState.userModel)),
                            (Route<dynamic> route) => false,
                          ));
                } else if (authState is AuthFailState) {
                  {
                    Timer(
                     const Duration(seconds: 7),
                      () =>
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BoardingScreen()),
                      (Route<dynamic> route) => false,
                    ));
                  }
                } else if (authState is AuthErrorState) {
                  showSnackBar(context, authState.message);
                }
              }, builder: (context, authState) {
                if (authState is AuthLoadingState) {
                  return const LoadingWidget();
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
