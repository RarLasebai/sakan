import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class CustomRadioButton extends StatelessWidget {
  final String groupValue, title;
  const CustomRadioButton(
      {super.key, required this.groupValue, required this.title});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      activeColor: primary,
      title: TxtStyle(title, 12, Colors.black, FontWeight.normal),
      value: title,
      groupValue: groupValue,
      onChanged: (value) {},
    );
  }
}
