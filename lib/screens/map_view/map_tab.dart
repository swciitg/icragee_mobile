import 'package:cloud_firestore/cloud_firestore.dart';
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
  GoogleMapController? _mapController;
  String _selectedLocation = "Auditorium";
  Set<Marker> _markers = {};
  final Map<String, CameraPosition> _locations = {};

  @override
  void initState() {
    super.initState();
    _fetchLocationsFromFirebase();
  }

  Future<void> _fetchLocationsFromFirebase() async {
    try {
      CollectionReference locationsRef =
          FirebaseFirestore.instance.collection('locations');
      QuerySnapshot querySnapshot = await locationsRef.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String locationName = data['name'];
        GeoPoint geoPoint = data['coordinate'];

        double latitude = geoPoint.latitude;
        double longitude = geoPoint.longitude;

        _locations[locationName] = CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 17,
        );
      }

      if (_locations.isNotEmpty) {
        setState(() {
          _selectedLocation = _locations.keys.first;
          _addMarker(_selectedLocation);
        });
      }
    } catch (e) {
      debugPrint("Error fetching locations: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      extendBodyBehindAppBar: true,
      body: _locations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                GoogleMap(
                  markers: _markers,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(() {
                      return EagerGestureRecognizer();
                    })
                  },
                  initialCameraPosition: _locations[_selectedLocation]!,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _addMarker(_selectedLocation);
                  },
                ),
                Positioned(
                  top: 75,
                  left: 1,
                  right: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _locations.keys.map((location) {
                          int index =
                              _locations.keys.toList().indexOf(location);
                          bool isFirst = index == 0;
                          bool isLast = index == _locations.keys.length - 1;

                          return Padding(
                            padding: EdgeInsets.only(
                              left: isFirst ? 16 : 5,
                              right: isLast ? 16 : 5,
                            ),
                            child: _buildTile(location,
                                isSelected: _selectedLocation == location),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Helper function to build the tile
  Widget _buildTile(String text, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLocation = text;
          _addMarker(_selectedLocation);
        });
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(_locations[text]!),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : MyColors.backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? MyColors.primaryColor : MyColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  void _addMarker(String location) {
    final position = _locations[location]!.target;
    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId(location),
          position: position,
          infoWindow: InfoWindow(title: location),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
    });
  }
}
