import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:sakan/features/auth/application/auth_cubit/auth_states.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/auth/presentation/screens/restore_password_screen.dart';
import 'package:sakan/features/profile/application/profile_cubit/profile_cubit.dart';
import 'package:sakan/features/profile/application/profile_cubit/profile_states.dart';
import 'package:sakan/features/profile/presentation/screens/contcat_us_screen.dart';
import 'package:sakan/features/profile/presentation/screens/edit_personal_data_screen.dart';
import 'package:sakan/features/profile/presentation/screens/my_houses_screen.dart';
import 'package:sakan/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:sakan/features/profile/presentation/widgets/profile_list_tile_widget.dart';
import 'package:sakan/features/splash_and_boarding/presentation/screens/splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
      AuthCubit authCubit = AuthCubit.get(context);
      if (state is AuthGetUser) {
        UserModel user = state.userModel;
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: BlocProvider.value(
                value: ProfileCubit(),
                child: BlocBuilder<ProfileCubit, ProfileStates>(
                    builder: (context, state) {
                  ProfileCubit profileCubit = ProfileCubit.get(context);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TxtStyle("الملف الشخصي", 18, Colors.black,
                              FontWeight.bold),
                        ),
                      ),
                      //header
                      BlocBuilder<ProfileCubit, ProfileStates>(
                          builder: (context, state) {
                        if (state is ProfileUpdatedSuccessfuly) {
                          return ProfileHeaderWidget(
                            name: state.userModel.userName,
                            phone: state.userModel.userPhone,
                            image: state.userModel.userPhoto,
                          );
                        } else if (state is ProfileLoadingState) {
                          return const LoadingWidget();
                        } else {
                          return ProfileHeaderWidget(
                            name: user.userName,
                            phone: user.userPhone,
                            image: user.userPhoto,
                          );
                        }
                      }),
                      //عروضي
                      ProfileListTileWidget(
                          title: "عروضي",
                          icon: "my_houses.png",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                          value: ProfileCubit(),
                                          child: MyHousesScreen(
                                              profileCubit: profileCubit),
                                        )));
                          }),
                      //البيانات الشخصية
                      ProfileListTileWidget(
                          title: "البيانات الشخصية",
                          icon: "Profile.png",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                          value: profileCubit,
                                          child: EditPersonalDataScreen(
                                              userModel: user,
                                              profileCubit: profileCubit),
                                        ))).then(
                                (value) => authCubit.getDataFromSharedPref());
                          }),
                      //الإعدادات
                      ProfileListTileWidget(
                          title: "الإعدادات",
                          icon: "Setting.png",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RestorePasswordScreen(
                                          isProfile: true,
                                        )));
                          }),

                      //تواصل معنا
                      ProfileListTileWidget(
                          title: "تواصل معنا",
                          icon: "hint.png",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContactUsScreen()));
                          }),

                      //تسجيل الخروج
                      ProfileListTileWidget(
                        title: "تسجيل الخروج",
                        icon: "Logout.png",
                        onPress: false,
                        onTap: () {
                          authCubit
                              .signOut()
                              .then((value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashScreen()),
                                    (Route<dynamic> route) => false,
                                  ));
                        },
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      } else {
        return const LoadingWidget();
      }
    });
  }
}
