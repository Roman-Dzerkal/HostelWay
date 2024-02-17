import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hostelway/resources/custom_colors.dart';

class HotelMapView extends StatelessWidget {
  final LatLng latLng;
  const HotelMapView({super.key, required this.latLng});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.keyboard_arrow_left, color: CustomColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: CustomColors.primary,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          scrollGesturesEnabled: true,
          initialCameraPosition: CameraPosition(zoom: 6, target: latLng),
          markers:
              {Marker(markerId: const MarkerId("1"), position: latLng)},
        ),
      ),
    );
  }
}

