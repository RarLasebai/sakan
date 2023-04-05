
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:sakan/features/form/presentation/screens/form_screen.dart';
import 'package:sakan/features/home/presentation/screens/home_screen.dart';
import 'package:sakan/features/profile/presentation/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/model/user_model.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //Variables
  //Bottom Navigation Bar
  int currentIndex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  static UserModel? user;

  List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const FormScreen(),
    const ProfileScreen()
  ];

  //Methods
  //Bottom Navigation Bar
  void changeBottomNavBarScreen(int index) {
    currentIndex = index;
    emit(BottomNavBarChangeScreenState());
  }

 

  Future signOut() async {
    await auth.signOut();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_signed_in", false);
    sharedPreferences.clear();
  }
}
