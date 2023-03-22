import 'package:flutter/material.dart';

class HouseImageScreen extends StatelessWidget {
  const HouseImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // height: 278.h,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/room.png"),
            ),
          ),
        ),
      ),
    );
  }
}
