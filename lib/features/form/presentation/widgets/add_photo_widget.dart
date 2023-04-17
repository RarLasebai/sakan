import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Container(
                                                    height: 60.h,
                                                    width: 60.w,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffFFEEEA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.r)),
                                                    child: const Icon(Icons
                                                        .add_a_photo_outlined)),
                                              ),
                                               const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TxtStyle(
                                                      "ارفع صور السكن",
                                                      14,
                                                      Colors.black,
                                                      FontWeight.normal),
                                                  TxtStyle(
                                                      "اختر صوراً واضحة لرفعها",
                                                      12,
                                                      darkGrey,
                                                      FontWeight.normal)
                                                ],
                                              )
                                            ],
                                          );
  }
}