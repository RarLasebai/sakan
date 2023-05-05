import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/profile/presentation/screens/roles_screen.dart';

class RolesWidget extends StatelessWidget {
  const RolesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 1.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const TxtStyle(
              "  قراءة الشروط والأحكام قبل البدأ.  ",
              12,
              Colors.red,
              FontWeight.normal,
              longText: true,
              textAlignm: TextAlign.center,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RolesScreen())),
              child: const TxtStyle(
                "من هنا!",
                12,
                Colors.red,
                FontWeight.bold,
                longText: true,
                textAlignm: TextAlign.center,
                textDecoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
