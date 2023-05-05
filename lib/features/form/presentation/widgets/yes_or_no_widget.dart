import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/widgets/radio_button_widget.dart';

class YesOrNoWidget extends StatelessWidget {
  final String title, groupValue;
    final void Function(Object?)? onChanged;

  const YesOrNoWidget({required this.title, required this.groupValue, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Icon(
                Icons.stream_sharp,
                color: primary,
              ),
              TxtStyle("  $title", 12, Colors.black, FontWeight.normal,
                  longText: true),
            ],
          ),
          CustomRadioButton(
            groupValue: groupValue,
            onChanged: onChanged,
            title: "نعم",
          ),
          CustomRadioButton(
            groupValue: groupValue,
            title: "لا",
            onChanged: onChanged,
          ),
        ]));
  }
}
