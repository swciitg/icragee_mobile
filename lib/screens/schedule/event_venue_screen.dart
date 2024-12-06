import 'package:flutter/material.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';

class EventVenueScreen extends StatelessWidget {
  const EventVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder(
            stream: DataService.getEventVenueStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final sections = snapshot.data!;
              return ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  final section = sections[index];
                  final last = index == sections.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(top: 16, bottom: last ? 16 : 0),
                    child: ListTile(
                      title: Text(section),
                      tileColor: Colors.white,
                      trailing: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog.adaptive(
                                  title: const Text('Delete Venue'),
                                  content:
                                      Text('Are you sure you want to delete venue : "$section" ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        navigatorKey.currentState!.pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        DataService.deleteEventVenue(section);
                                        navigatorKey.currentState!.pop();
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(Icons.delete_rounded),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final controller = TextEditingController();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: const Text('Add Venue'),
                  content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Material(
                      child: _buildTextField(controller, "Name"),
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
                        if (controller.text.trim().isNotEmpty) {
                          DataService.addEventVenue(controller.text.trim());
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
      title: const Text(
        'Event Venues',
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
