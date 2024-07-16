import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/emergency_contact.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/contacts_widget.dart';

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
// Usage

    return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Emergency'),
          backgroundColor: MyColors.backgroundColor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<EmergencyContact>>(
              future: DataService.fetchContactsByCategory('emergency'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ContactsWidget(contacts: snapshot.data!);
                } else {
                  return const Center(child: Text('No contacts found.'));
                }
              },
            )));
  }
}
