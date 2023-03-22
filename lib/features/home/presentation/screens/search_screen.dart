import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/presentation/widgets/house_widget.dart';
import 'package:sakan/features/home/presentation/widgets/search_button_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    // GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: TopNavBar("البحث"),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              //search field
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hint: "أدخل كلمة البحث",
                        controller: searchController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "من فضلك لا تترك الحقل فارغاً";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    const SearchButtonWidget()
                  ],
                ),
              ),
              Row(
                children: const [
                  Icon(
                    Icons.hive_outlined,
                    // size: 50,
                    color: primary,
                  ),
                  TxtStyle(
                    "يمكنك البحث بناءً على السعر، المنطقة أو حتى النوع!",
                    longText: true,
                    13,
                    darkGrey,
                    FontWeight.normal,
                    // textAlignm: TextAlign.center,
                  )
                ],
              ),
              //Search Result
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const HouseWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      const HouseWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      const HouseWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
