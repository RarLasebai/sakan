import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/features/form/presentation/widgets/expan_tile_widget.dart';
import 'package:sakan/features/form/presentation/widgets/field_widget.dart';
import 'package:sakan/features/form/presentation/widgets/success_dialog.dart';

import '../../../../core/utils/widgets/txt_style.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController costController = TextEditingController();
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TxtStyle(
                                "تأجير سكن", 18, Colors.black, FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const ExpanTile("icon", softRed, "حدد نوع السكن",
                            "حدد نوع السكن المراد عرضه"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              FieldWidget(
                                  hint: "السعر",
                                  icon: "cost.png",
                                  controller: costController),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: FieldWidget(
                                    hint: "اللون",
                                    icon: "color.png",
                                    controller: costController),
                              ),
                              FieldWidget(
                                  hint: "الموقع",
                                  icon: "location.png",
                                  controller: costController),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: FieldWidget(
                                    hint: "المنطقة",
                                    icon: "loca.png",
                                    controller: costController),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                        height: 60.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffFFEEEA),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: const Icon(
                                            Icons.add_a_photo_outlined)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      TxtStyle("ارفع صور السكن", 14,
                                          Colors.black, FontWeight.normal),
                                      TxtStyle("اختر صوراً واضحة لرفعها", 12,
                                          darkGrey, FontWeight.normal)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                              child: CustomButton(
                                  text: "أرسل النموذج",
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const SuccessDialog();
                                        });
                                  })),
                        )
                      ]),
                ))));
  }
}
