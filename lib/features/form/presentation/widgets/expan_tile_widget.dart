import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/form/application/form_cubit/form_cubit.dart';

import 'form_radio_button_widget.dart';

class ExpanTile extends StatefulWidget {
  const ExpanTile( this.color, this.title, this.subtitle, {required this.formCubit, Key? key})
      : super(key: key);
  final FormCubit formCubit;
  final Color color;
  final String title;
  final String subtitle;
  @override
  // ignore: library_private_types_in_public_api
  _ExpanTileState createState() => _ExpanTileState();
}

class _ExpanTileState extends State<ExpanTile> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: Container(
            decoration: BoxDecoration(
                border: Border.all(color: darkGrey, width: 1.w),
                borderRadius: BorderRadius.circular(35.r)),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.arrow_drop_down,
                size: 15,
                color: primary,
              ),
            )),
        leading: Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                color: const Color(0xffFFEEEA),
                borderRadius: BorderRadius.circular(15.r)),
            child: const Image(image: AssetImage("assets/icons/house.png"))),
        title: TxtStyle(widget.title, 14, Colors.black, FontWeight.w400),
        subtitle: TxtStyle(widget.subtitle, 14, darkGrey, FontWeight.w400),
        children:  <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 6.0,
                ),
                child: BlocProvider.value(
                    value: widget.formCubit,
                    child: FormRadioButton(
                      formCubit: widget.formCubit,))),
          ),
        ],
      ),
    );
  }
}
