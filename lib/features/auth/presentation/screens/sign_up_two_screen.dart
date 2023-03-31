// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/screens/home_layout.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_cubit.dart';
import 'package:sakan/features/auth/application/signup_cubit/signup_states.dart';
import 'package:sakan/features/auth/presentation/widgets/radio_button_widget.dart';

import '../../data/model/user_model.dart';

class SignUpTwoScreen extends StatelessWidget {
  final UserModel userModel;
  final SignupCubit signupCubit;
  const SignUpTwoScreen(
      {super.key, required this.signupCubit, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SignupCubit>(context),
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: signupCubit.signUpTwoFormKey,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 11,
                  right: 24,
                  left: 24,
                ),
                child: ListView(
                  children: [
                    Image.asset("assets/images/demo.png"),
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 16),
                      child: Center(
                        child: TxtStyle("أكمل تسجيل حسابك", 18, Colors.black,
                            FontWeight.bold),
                      ),
                    ),

                    //text fielda
                    CustomTextField(
                      hint: "العنوان",
                      controller: signupCubit.addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك لا تترك الحقل فارغاً";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CustomTextField(
                        hint: "الجنسية",
                        controller: signupCubit.nationalityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "من فضلك لا تترك الحقل فارغاً";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    //radio button
                    BlocBuilder<SignupCubit, SignupStates>(
                        builder: (context, state) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TxtStyle("الحالة الإجتماعية", 12, darkGrey,
                                FontWeight.normal),
                            //
                            CustomRadioButton(
                              groupValue: signupCubit.groupValue,
                              onChanged: signupCubit.onChanged("أعزب"),
                              title: "متزوج",
                            ),
                            CustomRadioButton(
                              groupValue: signupCubit.groupValue,
                              title: "متزوج",
                              onChanged: signupCubit.onChanged("متزوج"),
                            ),
                          ]);
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 16),
                      child: CustomButton(
                          text: "تسجيل",
                          onTap: () {
                            if (signupCubit.signUpTwoFormKey.currentState!
                                .validate()) {
                              userModel.userAddress =
                                  signupCubit.addressController.text;
                              userModel.userMartialStatus =
                                  signupCubit.groupValue;
                              userModel.userNationality =
                                  signupCubit.nationalityController.text;
                              signupCubit.saveUserDataToFirebase(
                                  userModel: userModel,
                                  context: context,
                                  onSuccess: () {
                                    //after saving data to firestore, then save it locally
                                    signupCubit.storeDataLocally().then(
                                        (value) {
                                      signupCubit.setSignin();
                                      print("saved");
                                    }).then((value) =>
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeLayout(
                                                        userModel: userModel)),
                                            (Route<dynamic> route) => false));
                                  });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
