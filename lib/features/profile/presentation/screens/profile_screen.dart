import 'package:flutter/material.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/screens/restore_password_screen.dart';
import 'package:sakan/features/profile/presentation/screens/contcat_us_screen.dart';
import 'package:sakan/features/profile/presentation/screens/edit_personal_data_screen.dart';
import 'package:sakan/features/profile/presentation/screens/my_houses_screen.dart';
import 'package:sakan/features/profile/presentation/widgets/profile_list_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TxtStyle(
                      "الملف الشخصي", 18, Colors.black, FontWeight.bold),
                ),
              ),

              //عروضي
              ProfileListTileWidget(
                  title: "عروضي",
                  icon: "my_houses.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHousesScreen()));
                  }),
              //البيانات الشخصية
              ProfileListTileWidget(
                  title: "البيانات الشخصية",
                  icon: "Profile.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const EditPersonalDataScreen()));
                  }),
              //الإعدادات
              ProfileListTileWidget(
                  title: "الإعدادات",
                  icon: "Setting.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RestorePasswordScreen(
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
                            builder: (context) => const ContactUsScreen()));
                  }),

              //تسجيل الخروج
              const ProfileListTileWidget(
                title: "تسجيل الخروج",
                icon: "Logout.png",
                onPress: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
