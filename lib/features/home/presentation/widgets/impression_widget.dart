import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';

import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/form/data/model/house_model.dart';
import 'package:sakan/features/home/application/homeCubit/home_cubit.dart';
import 'package:sakan/features/home/application/homeCubit/home_states.dart';

class ImpressionWidget extends StatelessWidget {
  final HouseModel houseModel;
  const ImpressionWidget({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomeCubit()..getHouse(houseModel.houseId),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const LoadingWidget();
            } else if (state is HouseImpressionUpdatedState) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: TxtStyle(
                        "الانطباعات", 14, Colors.black, FontWeight.bold),
                  ),
                  ConditionalBuilder(
                      condition: state is! HomeLoadingState,
                      builder: (context) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                  size: 40,
                                ),
                                Impress(
                                    color: Colors.green,
                                    value: state.smileCounter),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                  size: 40,
                                ),
                                Impress(
                                    color: Colors.amber, value: state.nCounter),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                Impress(
                                    color: Colors.red, value: state.sadCounter),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: TxtStyle("أضف انطباعك الخاص!", 14,
                                  Colors.black, FontWeight.bold),
                            ),
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: 3,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return const Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Colors.red,
                                    );

                                  case 1:
                                    return const Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );

                                  case 2:
                                    return const Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                  default:
                                    throw StateError("invalid state");
                                }
                              },
                              onRatingUpdate: (rating) {
                                showToast(
                                    context, "تم تسجيل انطباعك، شكراً لك!",
                                    color: Colors.green);
                              },
                            )
                          ],
                        );
                      },
                      fallback: (context) => const LoadingWidget())
                ],
              );
            } else {
              HomeCubit homeCubit = HomeCubit.get(context);
              homeCubit.sadCounter = houseModel.sadCount;
              homeCubit.smileCounter = houseModel.smileCount;
              homeCubit.nCounter = houseModel.neutralCount;

              return Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: TxtStyle(
                        "الانطباعات", 14, Colors.black, FontWeight.bold),
                  ),
                  ConditionalBuilder(
                      condition: state is! HomeLoadingState,
                      builder: (context) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                  size: 40,
                                ),
                                Impress(
                                    color: Colors.green,
                                    value: homeCubit.smileCounter!),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                  size: 40,
                                ),
                                Impress(
                                    color: Colors.amber,
                                    value: homeCubit.nCounter!),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                Impress(
                                    color: Colors.red,
                                    value: homeCubit.sadCounter!),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: TxtStyle("أضف انطباعك الخاص!", 14,
                                  Colors.black, FontWeight.bold),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return const Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Colors.red,
                                    );

                                  case 1:
                                    return const Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );

                                  case 2:
                                    return const Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                  default:
                                    throw StateError("invalid state");
                                }
                              },
                              onRatingUpdate: (rating) {
                                homeCubit
                                    .impressionUpdate(
                                        houseModel: houseModel,
                                        value: rating.toInt())
                                    .then((value) async {
                                  showToast(
                                      context, "تم تسجيل انطباعك، شكراً لك!",
                                      color: Colors.green);
                                });
                              },
                            )
                          ],
                        );
                      },
                      fallback: (context) => const LoadingWidget())
                ],
              );
            }
          }),
    );
  }
}

class Impress extends StatelessWidget {
  final int value;
  final Color color;
  const Impress({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          activeTickMarkColor: Colors.amber,
          trackHeight: 15,
          thumbColor: Colors.transparent,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0)),
      child: Slider(
        value: value.toDouble(),
        max: 10,
        min: 0,
        activeColor: color,
        inactiveColor: Colors.grey,
        onChanged: (double value) {},
      ),
    );
  }
}
