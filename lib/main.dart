import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/screens/home_layout.dart';
import 'package:sakan/features/splash_and_boarding/presentation/screens/splash_screen.dart';

import 'bloc_obs.dart';
import 'core/utils/colors/colors.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        color: primary,
        title: 'سـكن',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: const SplashScreen(),
      ),
    );
  }
}
