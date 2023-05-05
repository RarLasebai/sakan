import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakan/core/utils/colors/colors.dart';

import '../../../../core/utils/widgets/top_nav_bar.dart';

class ShowLocationScreen extends StatelessWidget {
  final String latlng;
  final bool isFullScreen;
  const ShowLocationScreen(
      {required this.latlng, this.isFullScreen = true, super.key});

  @override
  Widget build(BuildContext context) {
    List<String> substrings = latlng.split(",");
    final double lat = double.parse(substrings[0]);
    final double long = double.parse(substrings[1]);

    return Scaffold(
        appBar: isFullScreen ? TopNavBar("موقع السكن") : null,
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                  center: LatLng(lat, long), //Change to _position
                  zoom: 15.0),
              children: <Widget>[
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: <Marker>[
                  Marker(
                    point: LatLng(lat, long),
                    builder: (BuildContext context) {
                      return const Icon(
                        Icons.location_on,
                        size: 50,
                        color: primary,
                      );
                    },
                  )
                ]),
              ],
            ),
          ],
        ));
  }
}
