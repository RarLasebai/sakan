import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final int width;
  final bool isNumbers, isPhone, isPass;
  final VoidCallback? onTap;

  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.hint,
    required this.controller,
    required this.validator,
    this.isNumbers = false,
    this.isPass = false,
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
          obscureText: isPass,
          keyboardType:
              isNumbers == true ? TextInputType.number : TextInputType.text,
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
            suffixIcon: isPhone
                ? Container(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: TxtStyle(
                        "09 218+",
                        13,
                        Colors.black,
                        FontWeight.bold,
                      ),
                    ),
                  )
                : null,
            fillColor: softGrey,
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
                fontSize: 9.sp,
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
