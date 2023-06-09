import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class CustomRadioButton extends StatelessWidget {
  final dynamic groupValue;
  final String title;
  final void Function(Object?)? onChanged;
 const CustomRadioButton(
      {super.key,
      required this.groupValue,
      required this.title,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      activeColor: primary,
      toggleable: true,
      title: TxtStyle(title, 12, Colors.black, FontWeight.normal),
      value: title,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
