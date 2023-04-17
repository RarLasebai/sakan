import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/app_cubit/app_cubit.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';

import '../../app_cubit/app_states.dart';

class HomeLayout extends StatelessWidget {
  final UserModel userModel;
  const HomeLayout({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
            create: (BuildContext context) =>
                AuthCubit()..getDataFromSharedPref()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, appState) {
            AppCubit appCubit = AppCubit.get(context);

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: appCubit.screens[appCubit.currentIndex],
                bottomNavigationBar: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.r),
                  ),
                  child: Container(
                    height: 75.h,
                    color: darkGrey,
                    width: MediaQuery.of(context).size.width.sp,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        // sets the background color of the `BottomNavigationBar`
                        canvasColor: secondaryGrey,
                        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                        // primaryColor: Colors.red,
                        // textTheme: Theme.of(context).textTheme.copyWith(
                        //     caption: new TextStyle(color: Colors.yellow)),
                      ),
                      child: BottomNavigationBar(
                        elevation: 0,
                        onTap: ((value) {
                          appCubit.changeBottomNavBarScreen(value);
                        }),
                        unselectedItemColor: Colors.black,
                        showUnselectedLabels: false,
                        currentIndex: appCubit.currentIndex,
                        selectedItemColor: primary,
                        selectedLabelStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Changa',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: softGrey,
                        items: const [
                          BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/icons/Home.png"),
                            ),
                            label: "الرئيسية",
                          ),
                          BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/icons/heart.png"),
                            ),
                            label: "المفضلة",
                          ),
                          BottomNavigationBarItem(
                              icon: ImageIcon(
                                AssetImage("assets/icons/forms.png"),
                              ),
                              label: "تأجير سكن"),
                          BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/icons/Profile.png"),
                            ),
                            label: "الملف الشخصي",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
