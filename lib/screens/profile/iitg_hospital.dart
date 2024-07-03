import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../models/emergency_contact.dart';
import '../../services/data_service.dart';
import '../../widgets/contacts_widget.dart';

class IitgHospital extends StatelessWidget {
  const IitgHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          title: const Text('IITG Hospital'),
          backgroundColor: MyColors.backgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImportantContacts()));
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<EmergencyContact>>(
              future: DataService.fetchContactsByCategory('iitgHospital'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If there was an error, show an error message
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  // If data is available, display the list of contacts
                  List<EmergencyContact> contacts = snapshot.data!;
                  return ContactsWidget(contacts: contacts);
                } else {
                  return const Center(child: Text('No contacts found.'));
                }
              },
            )));
  }
}
