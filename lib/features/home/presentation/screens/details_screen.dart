// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/call_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/form/data/model/house_model.dart';
import 'package:sakan/features/home/presentation/screens/show_location_screen.dart';
import 'package:sakan/features/home/presentation/widgets/house_slider.dart';

class DetailsScreen extends StatelessWidget {
  final HouseModel houseModel;
  const DetailsScreen({required this.houseModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              HouseSlider(
                  imgList: houseModel.houseImages, houseId: houseModel.houseId),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //house type
                        Align(
                          alignment: Alignment.centerRight,
                          child: TxtStyle(
                              "${houseModel.houseType} - ${houseModel.houseArea}",
                              16,
                              Colors.black,
                              FontWeight.bold),
                        ),
                        //location
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowLocationScreen(
                                        latlng: houseModel.houseLocation)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: primary,
                                ),
                                TxtStyle("الموقع: ${houseModel.houseLocation}",
                                    12, darkGrey, FontWeight.normal,
                                    textDecoration: TextDecoration.underline),
                              ],
                            ),
                          ),
                        ),

                        //color and date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: TxtStyle("اللون", 16, Colors.black,
                                      FontWeight.bold),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: TxtStyle(houseModel.houseColors, 12,
                                        darkGrey, FontWeight.bold)),
                              ],
                            ),
                            houseModel.houseState != "accepted"
                                ? SizedBox()
                                : Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topRight,
                                        child: TxtStyle("تاريخ العرض", 16,
                                            Colors.black, FontWeight.bold),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: TxtStyle(houseModel.date, 12,
                                              darkGrey, FontWeight.bold)),
                                    ],
                                  ),
                          ],
                        ),
                        //description
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: TxtStyle(
                                  "الوصف", 16, Colors.black, FontWeight.bold),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: TxtStyle(
                                  houseModel.houseDesc,
//                                   '''
// لوريم إيبسوم نص وهمي وطريقة لكتابة النصوص وغالباً ما يستخدم في تخطيط الطباعة أو الرسوم البيانية أو تصميم الويب والنشر والتصميم الجرافيكي والغرض الأساسي من لوريم إيبسوم هو إنشاء نص لا يصرف الانتباه عن التخطيط العام والتسلسل الهرمي المرئي (باختصار إن الهدف هو الشكل وليس المحتوى) على الرغم من أن النص مكتوب باللاتينية إلا أنه ليس له أي معنى واضح إنه مجرد نص عام ويمكن استخدام ذلك النص قبل نشر النسخة النهائية
//                                      ''',
                                  12,
                                  darkGrey,
                                  longText: true,
                                  isDescribtion: true,
                                  FontWeight.bold,
                                  textAlignm: TextAlign.start,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              const Divider(
                color: primary,
              ),

              //call and cost

              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 6, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Align(
                            alignment: Alignment.topRight,
                            child: TxtStyle(
                                "السعر", 12, darkGrey, FontWeight.bold)),
                        Align(
                          alignment: Alignment.topRight,
                          child: TxtStyle("${houseModel.housePrice} LYD", 16,
                              Colors.black, FontWeight.bold),
                        ),
                      ],
                    ),
                    const CallWidget(isPink: true)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
