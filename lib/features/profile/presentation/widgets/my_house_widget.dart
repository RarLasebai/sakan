import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/functions/utils_functios.dart';
import 'package:sakan/core/utils/widgets/call_widget.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/form/data/model/house_model.dart';

class MyHouseWidget extends StatelessWidget {
  final HouseModel houseModel;
  const MyHouseWidget({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    final String status = getHouseStatusInArabic(houseModel.houseState);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: softGrey,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: softRed)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 172.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(houseModel.houseImages[0])),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TxtStyle(
                        "${houseModel.houseType} - ${houseModel.houseArea}",
                        16,
                        Colors.black,
                        FontWeight.bold),
                    //rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp,
                              color: darkGrey,
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: "الجودة: "),
                              TextSpan(
                                  text:
                                      "${houseModel.numberOfStars.toString()} نجوم",
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //cost
                    Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child:
                            //cost
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TxtStyle(
                                "السعر", 12, darkGrey, FontWeight.normal),
                            TxtStyle("${houseModel.housePrice} LYD", 16,
                                Colors.black, FontWeight.bold),
                          ],
                        )),
                    Row(
                      children: [
                        const TxtStyle(
                            "حالة الطلب:  ", 14, primary, FontWeight.w800),
                        TxtStyle(status, 14, Colors.black, FontWeight.w800),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        height: 50.h,
                        child: const CallWidget(
                          isPink: true,
                          isEdit: true,
                        ),
                      ),
                    )
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
/*
  
          
*/ 