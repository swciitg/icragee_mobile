import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/contacts_widget.dart';

import '../../models/emergency_contact.dart';
import '../../services/data_service.dart';

class Emergency extends StatelessWidget {
  Emergency({super.key});
  final DataService contactsDataService = DataService();

  @override
  Widget build(BuildContext context) {
// Usage

    return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Emergency'),
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
              future: contactsDataService.fetchContactsByCategory('emergency'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If there was an error, show an error message
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  // If data is available, display the list of contacts
                  List<EmergencyContact> contacts = snapshot.data!;
                  return ContactsWidget(contacts: contacts);
                } else {
                  return Center(child: Text('No contacts found.'));
                }
              },
            )));
  }
}
