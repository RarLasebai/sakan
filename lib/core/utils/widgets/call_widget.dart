import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class CallWidget extends StatelessWidget {
  final bool isPink;
  final bool isEdit;
  const CallWidget({super.key, this.isPink = false, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
          color: isPink ? primary : Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: isPink ? Colors.white : primary)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_enabled,
            color: isPink ? Colors.white : primary,
          ),
          TxtStyle(
              isEdit ? "  طلب تعديل" : "  اتصال",
              16,
              isPink ? Colors.white : primary,
              isEdit ? FontWeight.bold : FontWeight.normal),
        ],
      ),
    );
  }
}
