import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/presentation/widgets/house_type_widget.dart';

class FilterDialog extends StatelessWidget {
  final String filter;
  const FilterDialog({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
              border: Border.all(color: primary, width: 1.5),
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0.r)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TxtStyle(
                    "اختر طريقة الفرز:", 13, Colors.black, FontWeight.normal),
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "stars");
                      },
                      child: HouseTypeWidget(
                          isSelected: filter == "stars",
                          title: "الجودة",
                          isFilter: true),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "type");
                      },
                      child: HouseTypeWidget(
                          isSelected: filter == "type",
                          title: "النوع",
                          isFilter: true),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, "kitchen");
                        },
                        child: HouseTypeWidget(
                            isSelected: filter == "kitchen",
                            title: "عدد المطابخ",
                            isFilter: true),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, "toilet");
                        },
                        child: HouseTypeWidget(
                            isSelected: filter == "toilet",
                            title: "عدد الحمامات",
                            isFilter: true),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 13.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "rooms");
                      },
                      child: HouseTypeWidget(
                          isSelected: filter == "rooms",
                          title: "عدد الغرف",
                          isFilter: true),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "cost");
                      },
                      child: HouseTypeWidget(
                          isSelected: filter == "cost",
                          title: "السعر",
                          isFilter: true),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "area");
                      },
                      child: HouseTypeWidget(
                          isSelected: filter == "area",
                          title: "المنطقة",
                          isFilter: true),
                    ),
                  ],
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context, "kitchen");
                //   },
                //   child: TxtStyle("المنطقة", 14, Colors.black, FontWeight.bold),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
