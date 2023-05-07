// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/call_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/form/data/model/house_model.dart';
import 'package:sakan/features/home/presentation/screens/show_location_screen.dart';
import 'package:sakan/features/home/presentation/widgets/house_slider.dart';
import 'package:sakan/features/home/presentation/widgets/map_widget.dart';
import 'package:sakan/features/home/presentation/widgets/props_widget.dart';
import 'package:sakan/features/home/presentation/widgets/rating_widget.dart';

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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HouseSlider(
                            imgList: houseModel.houseImages,
                            houseId: houseModel.houseId),

                        //house type
                        Align(
                          alignment: Alignment.centerRight,
                          child: TxtStyle(
                              "${houseModel.houseType} - ${houseModel.houseArea}",
                              16,
                              Colors.black,
                              FontWeight.bold,
                              longText: true),
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
                                TxtStyle(
                                    "عرض الخريطة كاملة: ${houseModel.houseLocation} ",
                                    12,
                                    darkGrey,
                                    FontWeight.normal,
                                    longText: true,
                                    textDecoration: TextDecoration.underline),
                              ],
                            ),
                          ),
                        ),
                        //map widget
                        MapWidget(latlng: houseModel.houseLocation),

                        //rate

                        RatingWidget(stars: houseModel.numberOfStars),
                        Divider(),
                        //date
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.topRight,
                                    child: TxtStyle("أقل مدة للإيجار", 14,
                                        Colors.black, FontWeight.bold),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: TxtStyle(
                                          "${houseModel.minRentPeriod.toString()} أشهر",
                                          12,
                                          darkGrey,
                                          FontWeight.bold)),
                                ],
                              ),
                              houseModel.houseState != "accepted"
                                  ? SizedBox()
                                  : Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topRight,
                                          child: TxtStyle("تاريخ العرض", 14,
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
                        ),

                        //props - مواصفات
                        const Align(
                          alignment: Alignment.topRight,
                          child: TxtStyle(
                              "مواصفات", 14, Colors.black, FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              PropsWidget(
                                  title: "لون\nالسكن",
                                  subTitle: houseModel.houseColors,
                                  icon: "col"),
                              SizedBox(width: 5.w),
                              PropsWidget(
                                  title: "عدد\n الغرف",
                                  subTitle: houseModel.roomsCount.toString(),
                                  icon: "rooms"),
                              SizedBox(width: 5.w),
                              PropsWidget(
                                  title: "عدد \nالمطابخ",
                                  subTitle: houseModel.kitchenCount.toString(),
                                  icon: "kitchen"),
                              SizedBox(width: 5.w),
                              PropsWidget(
                                  title: "عدد\n الحمامات",
                                  subTitle: houseModel.toiletCount.toString(),
                                  icon: "toilet"),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        //خدمات متوفرة
                        const Align(
                          alignment: Alignment.topRight,
                          child: TxtStyle("خدمات متوفرة", 14, Colors.black,
                              FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              PropsWidget(
                                  title: "أثاث \nالسكن",
                                  subTitle: houseModel.furniture ? "نعم" : "لا",
                                  icon: "f"),
                              SizedBox(width: 5.w),
                              PropsWidget(
                                  title: "اتصال \nإنترنت",
                                  subTitle: houseModel.wifi ? "نعم" : "لا",
                                  icon: "wifi"),
                              SizedBox(width: 5.w),
                              PropsWidget(
                                  title: "فاتورة \nالمياه",
                                  subTitle: houseModel.water ? "نعم" : "لا",
                                  icon: "water"),
                              SizedBox(width: 5.w),
                              PropsWidget(
                                  title: "فاتورة\n الكهرباء",
                                  subTitle: houseModel.elec ? "نعم" : "لا",
                                  icon: "elec"),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),

                        //description
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: TxtStyle("معلومات إضافية", 14,
                                  Colors.black, FontWeight.bold),
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
