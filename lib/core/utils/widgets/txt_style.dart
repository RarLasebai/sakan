import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TxtStyle extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TxtStyle(this._text, this._size, this._color, this._fontWeight,
      {this.textDecoration,
      this.textAlignm,
      this.decorationColor,
      this.longText = false,
      this.isDescribtion = false});
  final String _text;
  final bool longText, isDescribtion;
  final Color _color;
  final double _size;
  final FontWeight _fontWeight;
  final TextDecoration? textDecoration;
  final TextAlign? textAlignm;
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    return Text(
        longText == false
            ? _text.length > 30
                ? '${_text.substring(0, 30)}...'
                : _text
            : _text,
        textAlign: textAlignm,
        maxLines: isDescribtion ? 20 : 2,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          decoration: textDecoration,
          decorationColor: decorationColor,
          fontFamily: 'Changa',
          color: _color,
          fontSize: _size.sp,
          fontWeight: _fontWeight,
        ));
  }
}
/*
Flexible(
    child: RichText(
    overflow: TextOverflow.ellipsis, // this will help add dots after maxLines
    maxLines: 2, // max lines after that dots comes
    strutStyle: StrutStyle(fontSize: 12.0),
    text: TextSpan(
             style: TextStyle(color: Colors.black),
             text: 'A very long text :)'
          ),
       ),
    ),
*/
