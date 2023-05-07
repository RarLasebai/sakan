import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: Container(
          height: 189.h,
          decoration: BoxDecoration(
              border: Border.all(color: primary, width: 1.5),
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "area");
                },
                child: TxtStyle("المنطقة", 14, Colors.black, FontWeight.bold),
              ),
              TxtStyle("السعر", 14, Colors.black, FontWeight.bold),
              TxtStyle("عدد الحمامات", 14, Colors.black, FontWeight.bold),
              TxtStyle("عدد الغرف", 14, Colors.black, FontWeight.bold),
              TxtStyle("عدد المطابخ", 14, Colors.black, FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }
}
