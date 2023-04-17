import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/auth/presentation/widgets/radio_button_widget.dart';
import 'package:sakan/features/form/application/form_cubit/form_cubit.dart';
import 'package:sakan/features/form/application/form_cubit/form_states.dart';

class FormRadioButton extends StatelessWidget {
  final FormCubit formCubit;
  const FormRadioButton({required this.formCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return //radio button
        BlocProvider.value(
      value: formCubit,
      child: BlocBuilder<FormCubit, FormStates>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomRadioButton(
              groupValue: formCubit.groupValue,
              onChanged: (_) => formCubit.houseTypeOnChanged("شقة"),
              title: "شقة",
            ),
            CustomRadioButton(
              groupValue: formCubit.groupValue,
              title: "منزل أرضي",
              onChanged: (_) => formCubit.houseTypeOnChanged("منزل أرضي"),
            ),
            CustomRadioButton(
              groupValue: formCubit.groupValue,
              title: "منزل بدورين",
              onChanged: (_) => formCubit.houseTypeOnChanged("منزل بدورين"),
            ),
            CustomRadioButton(
              groupValue: formCubit.groupValue,
              title: "أخرى",
              onChanged: (_) => formCubit.houseTypeOnChanged("أخرى"),
            ),
          ]),
        );
      }),
    );
  }
}
