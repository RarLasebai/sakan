import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/features/profile/presentation/widgets/my_house_widget.dart';

class MyHousesScreen extends StatelessWidget {
  const MyHousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar("عروضي"),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(19),
          child: Column(
            children: [
              const MyHouseWidget(
                status: "قيد التأكيد",
              ),
              SizedBox(height: 10.h),
              const MyHouseWidget(
                status: "تم العرض",
              )
            ],
          ),
        )),
      ),
    );
  }
}
