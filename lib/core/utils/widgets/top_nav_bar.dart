import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class TopNavBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double titleSize;
  final bool isMainScreen;
  @override
  final Size preferredSize;
  TopNavBar(this.title,
      {Key? key, this.titleSize = 15, this.isMainScreen = false})
      : preferredSize = Size.fromHeight(50.0.h),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TxtStyle(title, 18, Colors.black, FontWeight.bold),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 23,
          ),
        ));
  }
}
