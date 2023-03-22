import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

import 'radio_button_widget.dart';

class ExpanTile extends StatefulWidget {
  const ExpanTile(this.icon, this.color, this.title, this.subtitle, {Key? key})
      : super(key: key);
  final String icon;
  final Color color;
  final String title;
  final String subtitle;
  @override
  // ignore: library_private_types_in_public_api
  _ExpanTileState createState() => _ExpanTileState();
}

class _ExpanTileState extends State<ExpanTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      trailing: Container(
          decoration: BoxDecoration(
              border: Border.all(color: darkGrey, width: 1.w),
              borderRadius: BorderRadius.circular(35.r)),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_drop_down,
              size: 13,
            ),
          )),
      // contentPadding: const EdgeInsets.only(right: 24, left: 24),
      elevation: 0.0,
      borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
      leading: Container(
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
              color: const Color(0xffFFEEEA),
              borderRadius: BorderRadius.circular(15.r)),
          child: const Image(image: AssetImage("assets/icons/house.png"))),
      title: TxtStyle(widget.title, 14, Colors.black, FontWeight.w400),
      subtitle: TxtStyle(widget.subtitle, 14, darkGrey, FontWeight.w400),
      children: const <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(
                left: 6.0,
              ),
              child:
                  RadioButton("شقة", "منزل دور أرضي", "منزل بدورين", "أخرى")),
        ),
      ],
    );
  }
}
