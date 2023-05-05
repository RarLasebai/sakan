import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/widgets/radio_button_widget.dart';

class YesOrNoWidget extends StatelessWidget {
  final String title;
  const YesOrNoWidget({required this.title, super.key});

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
            groupValue: "formCubit.groupValue,",
            onChanged: (_) {
              // formCubit.houseTypeOnChanged("شقة")
            },
            title: "نعم",
          ),
          CustomRadioButton(
            groupValue: "formCubit.groupValue",
            title: "لا",
            onChanged: (_) {
              // formCubit.houseTypeOnChanged("منزل أرضي")
            },
          ),
        ]));
  }
}
