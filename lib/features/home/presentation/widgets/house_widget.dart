// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/call_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/presentation/screens/details_screen.dart';

import '../../../form/data/model/house_model.dart';

class HouseWidget extends StatelessWidget {
  final HouseModel houseModel;
  final bool isSearchScreen;

  const HouseWidget(
      {required this.houseModel, this.isSearchScreen = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: isSearchScreen ? softGrey : softGrey,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: softRed)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isSearchScreen
                        ? SizedBox(height: 1.h)
                        : Center(
                            child: Container(
                              width: 320.w,
                              height: 172.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        houseModel.houseImages[0])),
                              ),
                            ),
                          ),
                    isSearchScreen
                        ? RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: " ${houseModel.houseType}"),
                                TextSpan(
                                    text: " - ${houseModel.houseArea} ",
                                    style: const TextStyle(color: primary)),
                              ],
                            ),
                          )
                        : TxtStyle(
                            "${houseModel.houseType} - ${houseModel.houseArea}",
                            16,
                            Colors.black,
                            FontWeight.bold),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: primary,
                        ),
                        TxtStyle("الموقع: ${houseModel.houseLocation}", 12,
                            darkGrey, FontWeight.normal),
                      ],
                    ),

                    //cost and call
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 12),
                      child: SizedBox(
                        width: 300.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //cost
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TxtStyle(
                                    "السعر", 12, darkGrey, FontWeight.normal),
                                TxtStyle(
                                    "${houseModel.housePrice} LYD",
                                    16,
                                    isSearchScreen ? primary : Colors.black,
                                    FontWeight.bold),
                              ],
                            ),
                            //call icon
                            const CallWidget()
                          ],
                        ),
                      ),
                    ),
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
