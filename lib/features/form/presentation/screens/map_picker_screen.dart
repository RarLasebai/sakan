import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakan/core/utils/colors/colors.dart';
import 'package:sakan/core/utils/widgets/custom_button.dart';
import 'package:sakan/core/utils/widgets/show_toast.dart';
import 'package:sakan/core/utils/widgets/top_nav_bar.dart';
import 'package:sakan/core/utils/widgets/txt_style.dart';
import 'package:sakan/features/form/application/form_cubit/form_cubit.dart';

import '../../application/form_cubit/form_states.dart';

class MapPickerScreen extends StatelessWidget {
  const MapPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FormCubit>(context),
      child: BlocConsumer<FormCubit, FormStates>(
          listener: (context, state) {},
          builder: (context, state) {
            FormCubit formCubit = FormCubit();
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: TopNavBar("موقع السكن"),
                body: Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                          onLongPress: (tapPosition, point) {
                            formCubit.marker.clear();

                            formCubit.houseLocation = point;
                            formCubit.marker.add(Marker(
                              point: LatLng(point.latitude, point.longitude),
                              builder: (BuildContext context) {
                                return const Icon(
                                  Icons.location_on,
                                  size: 50,
                                  color: primary,
                                );
                              },
                            ));
                            showToast(context, "تم التحديد",
                                color: Colors.green);
                          },
                          center: LatLng(
                              32.885353, 13.180161), //Change to _position
                          zoom: 15.0),
                      children: <Widget>[
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: formCubit.marker,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: primary),
                                  color: const Color.fromARGB(172, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: primary,
                                  ),
                                  SizedBox(width: 3.w),
                                  const TxtStyle("اضغط مطوّلاً لتحديد موقع السكن", 12,
                                      primary, FontWeight.bold),
                                ],
                              )),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: CustomButton(
                                  text: "حفظ",
                                  onTap: () {
                                    if (formCubit.houseLocation == null) {
                                      showToast(context, "حدد موقع السكن");
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  })),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
