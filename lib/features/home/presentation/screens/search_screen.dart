import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/home/application/searchCubit/search_cubit.dart';
import 'package:sakan/features/home/application/searchCubit/search_states.dart';
import 'package:sakan/features/home/presentation/widgets/house_widget.dart';
import 'package:sakan/features/home/presentation/widgets/search_button_widget.dart';

import 'details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar("البحث"),
      body: BlocProvider(
        create: (context) => SearchCubit()..getSearchResult(),
        child:
            BlocConsumer<SearchCubit, SearchStates>(listener: (context, state) {
          if (state is SearchResultEmptyState) {
            showToast(context, state.message);
          }
        }, builder: (context, state) {
          SearchCubit searchCubit = SearchCubit.get(context);
          return Form(
            key: searchCubit.searchFormKey,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    //search field
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50.h,
                              child: CustomTextField(
                                hint: "أدخل كلمة البحث",
                                controller: searchCubit.searchController,
                                onChanged: ((text) => searchCubit.searchHouse(
                                    text, searchCubit.allHouses!)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                if (searchCubit.searchFormKey.currentState!
                                    .validate()) {
                                  searchCubit.getSearchResult();
                                }
                              },
                              child: const SearchButtonWidget())
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<SearchCubit, SearchStates>(
                          builder: (context, state) {
                        if (state is SearchLoadingState) {
                          return const LoadingWidget();
                        } else if (state is SearchErrorState) {
                          return const Center(
                            child: TxtStyle("حدث خطأ ما", 14, Colors.red,
                                FontWeight.normal),
                          );
                        } else if (state is SearchResultLoadedState) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                ...state.houses
                                    .map((house) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsScreen(
                                                          houseModel: house)));
                                        },
                                        child: HouseWidget(
                                          houseModel: house,
                                          isSearchScreen: true,
                                        )))
                                    .toList()
                              ],
                            ),
                          );
                        } else if (state is SearchResultEmptyState) {
                          return Center(
                            child: TxtStyle(
                                state.message, 14, darkGrey, FontWeight.normal),
                          );
                        } else {
                          return const Column(
                            children: [
                              // Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 60,
                                    color: primary,
                                  ),
                                  TxtStyle(
                                    "يمكنك البحث بناءً على السعر، المنطقة!",
                                    longText: true,
                                    14,
                                    darkGrey,
                                    FontWeight.normal,
                                    textAlignm: TextAlign.center,
                                  )
                                ],
                              ),
                              // Spacer(),
                            ],
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
