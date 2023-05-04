// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;
  const EmptyDataWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: TxtStyle(message, 16, darkGrey, FontWeight.normal)),
      ],
    );
  }
}
