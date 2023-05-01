import 'package:flutter/material.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';

class HouseImageScreen extends StatelessWidget {
  final String image;
  const HouseImageScreen({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(""),
      body: SafeArea(
        child: Container(
          // height: 278.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(image),
            ),
          ),
        ),
      ),
    );
  }
}
