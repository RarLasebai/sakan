// ignore_for_file: avoid_print

import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/loading_widget.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/features/form/application/form_cubit/form_cubit.dart';
import 'package:sakan/features/form/application/form_cubit/form_states.dart';
import 'package:sakan/features/form/presentation/screens/map_picker_screen.dart';
import 'package:sakan/features/form/presentation/widgets/add_photo_widget.dart';
import 'package:sakan/features/form/presentation/widgets/expan_tile_widget.dart';
import 'package:sakan/features/form/presentation/widgets/field_widget.dart';
import 'package:sakan/features/form/presentation/widgets/roles_widget.dart';
import 'package:sakan/features/form/presentation/widgets/rooms_count_text_field.dart';
import 'package:sakan/features/form/presentation/widgets/success_dialog.dart';

import '../../../../core/utils/widgets/txt_style.dart';
import '../widgets/yes_or_no_widget.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormCubit(),
      child: BlocConsumer<FormCubit, FormStates>(listener: (context, state) {
        if (state is FormSentSuccessfuly) {
          showDialog(
              context: context,
              builder: (context) {
                return const SuccessDialog();
              });
        }
        if (state is FormErrorState) {
          showToast(context, state.message);
        }

        if (state is PickingImageSuccessState) {
          showToast(context, "تم تحديد الصور بنجاح!", color: Colors.green);
        }
        if (state is PickingImageErrorState) {
          showToast(context, state.message);
        }
        if (state is HouseTypeErrorState) {
          showToast(context, state.message);
        }
      }, builder: (context, state) {
        FormCubit formCubit = FormCubit.get(context);

        return Form(
          key: formCubit.formDataKey,
          child: SafeArea(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                      padding: EdgeInsets.only(
                          right: 8,
                          left: 8,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: ListView(
                                children: [
                                  const Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: TxtStyle("تأجير سكن", 18,
                                          Colors.black, FontWeight.bold),
                                    ),
                                  ),
                                  const RolesWidget(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 15),
                                    child: ExpanTile(
                                        formCubit: formCubit,
                                        softRed,
                                        "حدد نوع السكن",
                                        "حدد نوع السكن المراد عرضه"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        FieldWidget(
                                            hint: "السعر",
                                            icon: "cost.png",
                                            isPrice: true,
                                            controller:
                                                formCubit.priceController),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: FieldWidget(
                                              hint: "اللون",
                                              icon: "color.png",
                                              controller:
                                                  formCubit.colorsController),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider.value(
                                                        value: formCubit,
                                                        child:
                                                            const MapPickerScreen())),
                                          ).then((value) {
                                            String location = value;
                                            formCubit.locationController
                                                .setText(location);
                                            print(value);
                                            print(location);
                                          }),
                                          child: FieldWidget(
                                              isLocation: true,
                                              hint: "الموقع",
                                              icon: "location.png",
                                              controller:
                                                  formCubit.locationController),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: FieldWidget(
                                              hint: "المنطقة",
                                              icon: "loca.png",
                                              controller:
                                                  formCubit.areaController),
                                        ),
                                        FieldWidget(
                                            hint: "أقل مدة للإيجار",
                                            icon: "my_houses.png",
                                            isPrice: true,
                                            controller: formCubit
                                                .minRentPeriodController),
                                        SizedBox(height: 10.h),
                                        FieldWidget(
                                            hint: "الوصف",
                                            icon: "my_houses.png",
                                            isDesc: true,
                                            controller:
                                                formCubit.descController),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: ConditionalBuilder(
                                                condition: state
                                                    is! PickingImageLoadingState,
                                                builder: (context) =>
                                                    GestureDetector(
                                                      onTap: () async {
                                                        formCubit.imagesFile =
                                                            await formCubit
                                                                .pickMultiImages();
                                                      },
                                                      child:
                                                          const AddPhotoWidget(),
                                                    ),
                                                fallback: (context) =>
                                                    const LoadingWidget())),
                                        ConditionalBuilder(
                                            condition: state
                                                is PickingImageSuccessState,
                                            builder: (context) {
                                              return SizedBox(
                                                height: 180.h,
                                                child: GridView.count(
                                                  mainAxisSpacing: 12,
                                                  crossAxisSpacing: 12,
                                                  shrinkWrap: true,
                                                  crossAxisCount: 2,
                                                  children: [
                                                    ...formCubit.imagesFile!
                                                        .map(
                                                            (image) =>
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15
                                                                              .r),
                                                                      border: Border.all(
                                                                          color:
                                                                              primary,
                                                                          width:
                                                                              .3.w)),
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  child: Image.file(
                                                                      File(image
                                                                          .path)),
                                                                ))
                                                        .toList()
                                                  ],
                                                ),
                                              );
                                            },
                                            fallback: (context) =>
                                                const SizedBox()),
                                        ////////////////////

                                        const Divider(
                                          color: primary,
                                        ),

                                        const Align(
                                          alignment: Alignment.centerRight,
                                          child: TxtStyle("معلومات إضافية", 13,
                                              Colors.black, FontWeight.bold),
                                        ),
                                        //Rooms
                                        RoomsCountTextField(
                                            kitchenController:
                                                formCubit.kitchenController,
                                            roomsController:
                                                formCubit.roomsController,
                                            toiletController:
                                                formCubit.toiletController),

                                        //furniture
                                        YesOrNoWidget(
                                          title:
                                              "هل السكن يتضمن الأثاث -مؤثث-؟",
                                          groupValue:
                                              formCubit.furnitureGroupValue,
                                          onChanged: (value) => formCubit
                                              .furnitureOnChanged(value),
                                        ),

                                        //elec
                                        YesOrNoWidget(
                                          title:
                                              "هل تكاليف فاتورة الكهرباء مدفوعة؟",
                                          groupValue: formCubit.elecGroupValue,
                                          onChanged: (value) =>
                                              formCubit.elecOnChanged(value),
                                        ),

                                        //water
                                        YesOrNoWidget(
                                          title:
                                              "هل تكاليف فاتورة المياه مدفوعة؟",
                                          groupValue: formCubit.waterGroupValue,
                                          onChanged: (value) =>
                                              formCubit.waterOnChanged(value),
                                        ),

                                        //wifi
                                        YesOrNoWidget(
                                            title:
                                                "هل يوجد اتصال إنترنت مجاني؟",
                                            groupValue:
                                                formCubit.wifiGroupValue,
                                            onChanged: (value) {
                                              formCubit.wifiOnChanged(value);
                                              print(value);
                                            }),

                                        ///////////////////////////////////////////////////
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Center(
                                        child: ConditionalBuilder(
                                            condition:
                                                state is! FormLoadingState,
                                            fallback: (context) =>
                                                const LoadingWidget(),
                                            builder: (context) {
                                              return CustomButton(
                                                  text: "أرسل النموذج",
                                                  onTap: () {
                                                    if (formCubit.formDataKey
                                                            .currentState!
                                                            .validate() &&
                                                        formCubit.imagesFile !=
                                                            null) {
                                                      formCubit
                                                          .saveHouseDataToFirebase(
                                                              context);
                                                    }
                                                    if (formCubit.imagesFile ==
                                                        null) {
                                                      showToast(context,
                                                          "لا يمكن إرسال النموذج بدون صور!");
                                                    }
                                                  });
                                            })),
                                  ),
                                ],
                              ),
                            )
                          ])))),
        );
      }),
    );
  }
}
