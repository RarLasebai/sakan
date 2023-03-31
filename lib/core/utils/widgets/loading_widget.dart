import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 16),
      child: Center(
        child: CircularProgressIndicator(color: primary),
      ),
    );
  }
}
