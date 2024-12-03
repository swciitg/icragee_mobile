import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icragee_mobile/models/coordinate_model.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  GoogleMapController? _mapController;
  String _selectedSection = "Auditorium";
  Set<Marker> _markers = {};
  LatLng? _selectedPosition;
  List<CoordinateModel> _currentCoordinates = [];
  List<String> _locationSections = [];

  @override
  void initState() {
    super.initState();
    _fetchLocationsFromFirebase();
  }

  Future<void> _fetchLocationsFromFirebase() async {
    try {
      CollectionReference locationsRef = FirebaseFirestore.instance.collection('locations');
      QuerySnapshot querySnapshot = await locationsRef.get();

      final locations = querySnapshot.docs
          .map((e) => (e.data() as Map<String, dynamic>)['name'] as String)
          .toList();

      _locationSections = locations;
      _selectedSection = _locationSections.first;
      _fetchSectionCoordinates();
    } catch (e) {
      debugPrint("Error fetching locations: $e");
    }
  }

  Future<void> _fetchSectionCoordinates() async {
    final ref = FirebaseFirestore.instance
        .collection('locations')
        .doc(_selectedSection)
        .collection('coordinates');
    QuerySnapshot querySnapshot = await ref.get();

    final coordinates = querySnapshot.docs
        .map((e) => CoordinateModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();

    _currentCoordinates = coordinates;
    _selectedPosition = LatLng(
      _currentCoordinates.first.coordinate.latitude,
      _currentCoordinates.first.coordinate.longitude,
    );
    _addMarkers(coordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      extendBodyBehindAppBar: false,
      body: _locationSections.isEmpty || _currentCoordinates.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  markers: _markers,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(() {
                      return EagerGestureRecognizer();
                    })
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(_selectedPosition!.latitude, _selectedPosition!.longitude),
                      zoom: 18),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                ),
                Positioned(
                  top: 0,
                  left: 1,
                  right: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_locationSections.length, (index) {
                          final location = _locationSections[index];
                          final isFirst = index == 0;
                          final isLast = index == _locationSections.length - 1;
                          return Padding(
                            padding: EdgeInsets.only(
                              left: isFirst ? 16 : 5,
                              right: isLast ? 16 : 5,
                            ),
                            child: _buildTile(location, isSelected: _selectedSection == location),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: kBottomNavigationBarHeight + 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: FloatingActionButton(
                          onPressed: _openMap,
                          backgroundColor: MyColors.primaryColor,
                          child: Icon(
                            Icons.directions_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _buildCurrentCoordinateNames()
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Future<void> _openMap() async {
    final latitude = _selectedPosition!.latitude;
    final longitude = _selectedPosition!.longitude;
    String url = Platform.isAndroid
        ? 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude'
        : 'https://maps.apple.com/?q=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showSnackBar('Could not open the map.');
    }
  }

  Widget _buildCurrentCoordinateNames() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_currentCoordinates.length, (index) {
            final location = _currentCoordinates[index];
            final isFirst = index == 0;
            final isLast = index == _currentCoordinates.length - 1;
            final isSelected = _selectedPosition ==
                LatLng(location.coordinate.latitude, location.coordinate.longitude);
            return GestureDetector(
              onTap: () {
                _selectedPosition =
                    LatLng(location.coordinate.latitude, location.coordinate.longitude);
                setState(() {});
                _mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(_selectedPosition!.latitude, _selectedPosition!.longitude),
                      zoom: 19,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? 16 : 5,
                  right: isLast ? 16 : 5,
                ),
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
                    _currentCoordinates[index].title,
                    style: TextStyle(
                      color: isSelected ? MyColors.primaryColor : MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
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
    );
  }

  // Helper function to build the tile
  Widget _buildTile(String text, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () async {
        _selectedSection = text;
        await _fetchSectionCoordinates();
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(_selectedPosition!.latitude, _selectedPosition!.longitude),
              zoom: 18,
            ),
          ),
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

  void _addMarkers(List<CoordinateModel> coordinates) {
    Set<Marker> updatedSet = {};
    for (var element in coordinates) {
      final marker = Marker(
        markerId: MarkerId(
            "$_selectedSection-${element.coordinate.latitude}-${element.coordinate.longitude}"),
        position: LatLng(element.coordinate.latitude, element.coordinate.longitude),
        infoWindow: InfoWindow(title: element.title),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          _selectedPosition = LatLng(element.coordinate.latitude, element.coordinate.longitude);
          setState(() {});
        },
      );
      updatedSet.add(marker);
    }
    setState(() {
      _markers = updatedSet;
    });
  }
}
