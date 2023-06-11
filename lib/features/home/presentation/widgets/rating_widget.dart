// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';

class RatingStarsWidget extends StatelessWidget {
  final int stars;
  const RatingStarsWidget({required this.stars, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TxtStyle("الجودة", 14, Colors.black, FontWeight.bold),
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: stars.toDouble(),
            // initialRating: studentModel.studentStars!.toDouble(),
            direction: Axis.horizontal,
            itemCount: 5,
            // itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
            itemBuilder: (context, _) => const Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
            ),
            onRatingUpdate: (rating) {
              // studentModel.studentStars = rating.toInt();
              // cubit.updateStars(studentModel);
              print(rating);
            },
          ),
        ],
      ),
    );
  }
}
