import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final int width;
  final bool isPhone;
  final VoidCallback? onTap;

  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.hint,
    required this.controller,
    required this.validator,
    this.isPhone = false,
    this.onTap,
    this.width = 327,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: TextFormField(
          keyboardType:
              isPhone == true ? TextInputType.number : TextInputType.text,
          // inputFormatters: [
          //   LengthLimitingTextInputFormatter(14),
          // ],
          validator: validator,
          controller: controller,
          cursorColor: primary,
          style: TextStyle(
              fontFamily: 'Changa',
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            // suffixIcon: isNote
            //     ? GestureDetector(
            //         onTap: onTap,
            //         child: const Icon(
            //           Icons.clear,
            //           color: Colors.red,
            //         ))
            //     : null,
            fillColor: secondaryGrey,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: primary)),
            hintText: hint,
            hintStyle: TextStyle(
                fontFamily: 'Changa',
                color: darkGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
            errorStyle: TextStyle(
                height: 0,
                fontFamily: 'Changa',
                color: Colors.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15.r),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(color: softGrey),
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }
}
