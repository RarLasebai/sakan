import 'package:flutter/material.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/presentation/screens/sign_up_one_screen.dart';
import 'package:sakan/features/splash_and_boarding/domain/entities/boarding_model.dart';
import 'package:sakan/features/splash_and_boarding/presentation/widgets/board_item_widget.dart';

// ignore: must_be_immutable
class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController boardingController = PageController();
  bool isLast = false;
  String next = "التالي";

  final List<BoardingModel> bordingItems = [
    BoardingModel(
        image: "assets/images/boarding1.png",
        title: "ابحث عن سكن بسهولة!",
        description: "تصفح قائمة المرافق القابلة للسكن بسهولة وسرعة!"),
    BoardingModel(
        image: "assets/images/boarding2.png",
        title: "عروض مختلفة في مكان واحد!",
        description: "شقق، منازل أرضية، منازل بدورين،\n وهناك المزيد!"),
    BoardingModel(
        image: "assets/images/boarding3.png",
        title: "حقق متطلباتك بشكل أسرع!",
        description: "لا داعي للبحث أكثر، تواصل مع زبونك من مكان واحد!")
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardingController,
              onPageChanged: (int index) {
                if (index == bordingItems.length - 1) {
                  setState(() {
                    isLast = true;
                    next = "التسجيل";
                  });
                } else {
                  setState(() {
                    isLast = false;
                    next = "التالي";
                  });
                }
              },
              itemBuilder: (context, index) => BoardItemWidget(
                boardingModel: bordingItems[index],
                index: index,
                length: bordingItems.length,
                pageController: boardingController,
              ),
              itemCount: bordingItems.length,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isLast) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpOneScreen()),
                    (Route<dynamic> route) => false);
              } else {
                boardingController.nextPage(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.easeIn);
              }
            },
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 246, bottom: 66),
                  child: CircleAvatar(
                    backgroundColor: softRed,
                    radius: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 244, bottom: 78),
                  child: TxtStyle(
                    next,
                    18,
                    darkRed,
                    FontWeight.w700,
                    longText: true,
                    textAlignm: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
