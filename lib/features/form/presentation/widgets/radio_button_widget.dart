import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class RadioButton extends StatefulWidget {
  const RadioButton(this.text1, this.text2, this.text3, this.text4,
      {super.key, this.icon});
  final String text1, text2, text3, text4;
  final bool? icon;

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  // ignore: prefer_typing_uninitialized_variables
  var group;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 70),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                    activeColor: primary,
                    value: 1,
                    groupValue: group,
                    onChanged: (T) {
                      setState(() {
                        group = T;
                      });
                    }),
                SizedBox(width: 14.w),
                TxtStyle(widget.text1, 10, Colors.black, FontWeight.normal)
              ],
            ),
            Row(
              children: [
                Radio(
                    activeColor: primary,
                    value: 2,
                    groupValue: group,
                    onChanged: (T) {
                      setState(() {
                        group = T;
                      });
                    }),
                SizedBox(width: 14.w),
                TxtStyle(widget.text2, 10, Colors.black, FontWeight.normal)
              ],
            ),
            Row(
              children: [
                Radio(
                    activeColor: primary,
                    value: 3,
                    groupValue: group,
                    onChanged: (T) {
                      setState(() {
                        group = T;
                      });
                    }),
                SizedBox(width: 14.w),
                TxtStyle(widget.text3, 10, Colors.black, FontWeight.normal)
              ],
            ),
            Row(
              children: [
                Radio(
                    activeColor: primary,
                    value: 4,
                    groupValue: group,
                    onChanged: (T) {
                      setState(() {
                        group = T;
                      });
                    }),
                SizedBox(width: 14.w),
                TxtStyle(widget.text4, 10, Colors.black, FontWeight.normal)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
