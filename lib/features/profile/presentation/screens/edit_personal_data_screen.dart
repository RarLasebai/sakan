import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/custom_text_field.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/auth/data/model/user_model.dart';
import 'package:sakan/features/profile/application/profile_cubit/profile_cubit.dart';
import 'package:sakan/features/profile/application/profile_cubit/profile_states.dart';
import 'package:sakan/features/profile/presentation/widgets/edit_profile_photo_widget.dart';

class EditPersonalDataScreen extends StatelessWidget {
  final UserModel userModel;
  final ProfileCubit profileCubit;
  const EditPersonalDataScreen(
      {required this.userModel, required this.profileCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileCubit,
      child:
          BlocConsumer<ProfileCubit, ProfileStates>(listener: (context, state) {
        if (state is NoDataChangedState) {
          showToast(context, "لا توجد بيانات محدثة");
          Navigator.pop(context);
        } else if (state is ProfileUpdatedSuccessfuly) {
          showToast(context, "تم تحديث البيانات بنجاح", color: Colors.green);
          Navigator.pop(context);
        } else if (state is ProfileErrorState) {
          showToast(
            context,
            "حدث خطأ ما، حاول مجدداً",
          );
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        ProfileCubit profileCubit = ProfileCubit.get(context);

        changePhoto() {
          profileCubit.changePhoto(context, userModel);
        }

        return Scaffold(
          appBar: TopNavBar("تعديل البيانات الشخصية"),
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 17, left: 31, bottom: 10, top: 15),
                  child: Form(
                    key: profileCubit.editProfileDataKey,
                    child: BlocBuilder<ProfileCubit, ProfileStates>(
                        builder: (context, state) {
                      // if (state is ProfileLoadingState) {
                      //   return
                      // }
                      if (state is ProfileUpdatedSuccessfuly) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditProfilePhotoWidget(
                              onTap: () {
                                changePhoto();
                              },
                              image: userModel.userPhoto,
                            ),
                            const TxtStyle(
                                "الاسم", 14, darkGrey, FontWeight.normal),
                            CustomTextField(
                                hint: state.userModel.userName,
                                controller: profileCubit.nameController,
                                validator: (val) {
                                  return null;
                                }),
                            SizedBox(height: 10.h),
                            const TxtStyle(
                                "المنطقة", 14, darkGrey, FontWeight.normal),
                            CustomTextField(
                                hint: state.userModel.userAddress,
                                controller: profileCubit.addressController,
                                validator: (val) {
                                  return null;
                                }),
                            SizedBox(height: 10.h),
                            const TxtStyle(
                                "الجنسية", 14, darkGrey, FontWeight.normal),
                            CustomTextField(
                                hint: state.userModel.userNationality,
                                controller: profileCubit.nationalityController,
                                validator: (val) {
                                  return null;
                                }),
                            SizedBox(height: 15.h),
                            ConditionalBuilder(
                              fallback: (context) => const LoadingWidget(),
                              condition: state is! ProfileLoadingState,
                              builder: (context) => CustomButton(
                                  text: "حفظ",
                                  onTap: () {
                                    profileCubit
                                        .updateProfileData(state.userModel);
                                  }),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditProfilePhotoWidget(
                              onTap: () {
                                changePhoto();
                              },
                              image: userModel.userPhoto,
                            ),
                            const TxtStyle(
                                "الاسم", 14, darkGrey, FontWeight.normal),
                            CustomTextField(
                                hint: userModel.userName,
                                controller: profileCubit.nameController,
                                validator: (val) {
                                  return null;
                                }),
                            SizedBox(height: 10.h),
                            const TxtStyle(
                                "المنطقة", 14, darkGrey, FontWeight.normal),
                            CustomTextField(
                                hint: userModel.userAddress,
                                controller: profileCubit.addressController,
                                validator: (val) {
                                  return null;
                                }),
                            SizedBox(height: 10.h),
                            const TxtStyle(
                                "الجنسية", 14, darkGrey, FontWeight.normal),
                            CustomTextField(
                                hint: userModel.userNationality,
                                controller: profileCubit.nationalityController,
                                validator: (val) {
                                  return null;
                                }),
                            SizedBox(height: 15.h),
                            ConditionalBuilder(
                              fallback: (context) => const LoadingWidget(),
                              condition: state is! ProfileLoadingState,
                              builder: (context) => CustomButton(
                                  text: "حفظ",
                                  onTap: () {
                                    profileCubit.updateProfileData(userModel);
                                  }),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                ),
              )),
        );
      }),
    );
  }
}
