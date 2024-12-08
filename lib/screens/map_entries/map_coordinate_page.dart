import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/coordinate_model.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';

class MapCoordinatePage extends StatelessWidget {
  final String section;
  const MapCoordinatePage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder(
            stream: DataService.getMapSectionCoordinates(section),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final coordinates = snapshot.data!;
              return ListView.builder(
                itemCount: coordinates.length,
                itemBuilder: (context, index) {
                  final coordinate = coordinates[index];
                  final last = index == coordinates.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(top: 16, bottom: last ? 16 : 0),
                    child: ListTile(
                      title: Text(coordinate.title),
                      tileColor: Colors.white,
                      trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog.adaptive(
                                    title: const Text('Delete Coordinate'),
                                    content: const Text(
                                        'Are you sure you want to delete this coordinate?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          navigatorKey.currentState!.pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          DataService.deleteMapSectionCoordinate(
                                              section, coordinate.id);
                                          navigatorKey.currentState!.pop();
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Icon(Icons.delete_rounded)),
                      leading: GestureDetector(
                        onTap: () {
                          final title = TextEditingController(text: coordinate.title);
                          final lat = TextEditingController(
                              text: coordinate.coordinate.latitude.toString());
                          final long = TextEditingController(
                              text: coordinate.coordinate.longitude.toString());
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog.adaptive(
                                  backgroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  title: const Text('Add Coordinate'),
                                  content: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Material(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _buildTextField(title, "Title"),
                                          const SizedBox(height: 8),
                                          _buildTextField(lat, "Latitude (decimal)",
                                              keyboardType: TextInputType.number),
                                          const SizedBox(height: 8),
                                          _buildTextField(long, "Longitude (decimal)",
                                              keyboardType: TextInputType.number),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final latValue = double.tryParse(lat.text.trim()) ?? 0.0;
                                        final longValue = double.tryParse(long.text.trim()) ?? 0.0;
                                        if (latValue == 0.0 || longValue == 0.0) {
                                          showSnackBar('Invalid latitude or longitude');
                                          return;
                                        }
                                        if (title.text.trim().isNotEmpty) {
                                          final model = CoordinateModel(
                                            id: coordinate.id,
                                            title: title.text.trim(),
                                            coordinate: GeoPoint(latValue, longValue),
                                          );
                                          DataService.updateMapSectionCoordinate(section, model);
                                        }
                                        navigatorKey.currentState!.pop();
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(Icons.edit_rounded),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      subtitle: Text(
                        'Lat: ${coordinate.coordinate.latitude}, Long: ${coordinate.coordinate.longitude}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final title = TextEditingController();
          final lat = TextEditingController(text: '0.0');
          final long = TextEditingController(text: '0.0');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  title: const Text('Add Coordinate'),
                  content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Material(
                      child: Column(
                        children: [
                          _buildTextField(title, "Title"),
                          const SizedBox(height: 8),
                          _buildTextField(lat, "Latitude (decimal)",
                              keyboardType: TextInputType.number),
                          const SizedBox(height: 8),
                          _buildTextField(long, "Longitude (decimal)",
                              keyboardType: TextInputType.number),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final latValue = double.tryParse(lat.text.trim()) ?? 0.0;
                        final longValue = double.tryParse(long.text.trim()) ?? 0.0;
                        if (latValue == 0.0 || longValue == 0.0) {
                          showSnackBar('Invalid latitude or longitude');
                          return;
                        }
                        if (title.text.trim().isNotEmpty) {
                          final id = DateTime.now().millisecondsSinceEpoch.toString();
                          final model = CoordinateModel(
                            id: id,
                            title: title.text.trim(),
                            coordinate: GeoPoint(latValue, longValue),
                          );
                          DataService.addMapSectionCoordinate(section, model);
                        }
                        navigatorKey.currentState!.pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              });
        },
        backgroundColor: MyColors.primaryColor,
        foregroundColor: MyColors.whiteColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int? maxLength, int? maxLines}) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        hintText: label,
        hintStyle: const TextStyle(color: Colors.black26),
        filled: true,
        fillColor: Colors.white,
        border: _buildInputBorder(),
        enabledBorder: _buildInputBorder(),
        focusedBorder: _buildInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        section,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
      ),
      backgroundColor: MyColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }
}
