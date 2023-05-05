import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/features/home/presentation/screens/show_location_screen.dart';

class MapWidget extends StatelessWidget {
  final String latlng;

  const MapWidget({required this.latlng, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 188.h,
        decoration: BoxDecoration(
            border: Border.all(color: primary, width: 1.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(1.r)),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ShowLocationScreen(latlng: latlng)));
            },
            child: ShowLocationScreen(latlng: latlng, isFullScreen: false)));
  }
}
