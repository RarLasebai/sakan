
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/call_widget.dart';
import 'package:sakan/core/utils/widgets/on_stack_icon.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/form/data/model/house_model.dart';

class FavoriteHouseWidget extends StatelessWidget {
  final HouseModel houseModel;
  const FavoriteHouseWidget({required this.houseModel, super.key});

  @override
  Widget build(BuildContext context) {
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
              Center(
                child: Stack(
                  children: [
                    //image
                    Center(
                      child: Container(
                        width: 320.w,
                        height: 172.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(houseModel.houseImages[0])),
                        ),
                      ),
                    ),
                    //fav icon
                    const OnStackIcon(isFav: true, isFavScreen: true),
                  ],
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
                              const TextSpan(text: "التقييم: "),
                              TextSpan(
                                  text: " 75%",
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
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
                                TxtStyle("${houseModel.housePrice} LYD", 16,
                                    Colors.black, FontWeight.bold),
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
