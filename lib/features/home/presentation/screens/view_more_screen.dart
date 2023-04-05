import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/features/home/presentation/widgets/house_type_widget.dart';
import 'package:sakan/features/home/presentation/widgets/house_widget.dart';

class ViewMoreScreen extends StatelessWidget {
  const ViewMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar("آخر المساكن المضافة"),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 25),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HouseTypeWidget(isSelected: true, title: "شقق"),
                      HouseTypeWidget(isSelected: false, title: "منازل بدورين"),
                      HouseTypeWidget(isSelected: false, title: "منزل أرضي"),
                      HouseTypeWidget(isSelected: false, title: "جاراج"),
                      HouseTypeWidget(isSelected: false, title: "شقق"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HouseWidget(),
                      SizedBox(
                        height: 10.w,
                      ),
                      const HouseWidget(),
                      SizedBox(
                        height: 10.w,
                      ),
                      const HouseWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
