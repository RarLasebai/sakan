import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/widgets/radio_button_widget.dart';

class EditPersonalDataScreen extends StatelessWidget {
  const EditPersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController personalProofController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController nationalityController = TextEditingController();
    String groupValue = "أعزب";

    // GlobalKey<FormState> signUpOneFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: TopNavBar("تعديل البيانات الشخصية"),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 17, left: 31, bottom: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TxtStyle("الاسم", 14, darkGrey, FontWeight.normal),
                  CustomTextField(
                      hint: "الاسم",
                      controller: nameController,
                      validator: (val) {
                        return null;
                      }),
                  SizedBox(height: 10.h),
                  const TxtStyle("رقم الهاتف", 14, darkGrey, FontWeight.normal),
                  CustomTextField(
                      hint: "رقم الهاتف",
                      isNumbers: true,
                      controller: phoneController,
                      validator: (val) {
                        return null;
                      }),
                  SizedBox(height: 10.h),
                  const TxtStyle(
                      "الإثبات الشخصي", 14, darkGrey, FontWeight.normal),
                  CustomTextField(
                      hint: "الإثبات الشخصي",
                      controller: personalProofController,
                      validator: (val) {
                        return null;
                      }),
                  SizedBox(height: 10.h),
                  const TxtStyle("المنطقة", 14, darkGrey, FontWeight.normal),
                  CustomTextField(
                      hint: "المنطقة",
                      controller: cityController,
                      validator: (val) {
                        return null;
                      }),
                  SizedBox(height: 10.h),
                  const TxtStyle("الجنسية", 14, darkGrey, FontWeight.normal),
                  CustomTextField(
                      hint: "الجنسية",
                      controller: nationalityController,
                      validator: (val) {
                        return null;
                      }),
                  SizedBox(height: 10.h),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TxtStyle("الحالة الإجتماعية", 12, darkGrey,
                            FontWeight.normal),
                      //   CustomRadioButton(
                      //       groupValue: groupValue, title: "أعزب"),
                      //   CustomRadioButton(
                      //       groupValue: groupValue, title: "متزوج"),
                      ]),
                  SizedBox(height: 10.h),
                  CustomButton(text: "حفظ", onTap: () {}),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          )),
    );
  }
}
