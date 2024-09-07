import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icragee_mobile/shared/colors.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: MyColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        title: Text(
          "Map",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: MyColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(() {
            return EagerGestureRecognizer();
          })
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(26.192613073419974, 91.69907177061708),
          zoom: 15,
        ),
      ),
    );
  }
}
