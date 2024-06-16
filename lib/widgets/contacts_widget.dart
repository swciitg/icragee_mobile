import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

class ContactsWidget extends StatelessWidget {
  final String title;
  final List<EmergencyContact> contacts;
  const ContactsWidget({
    super.key,
    required this.title,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: MyColors.navBarBackgroundColor,
        ),
        body: Column(children: [
          Container(
            color: MyColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Contact No',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  tileColor: MyColors.primaryColor,
                  title: Text(
                    contact.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Text(contact.contactNumber,
                      style: TextStyle(fontSize: 18)),
                );
              },
            ),
          ),
        ]));
  }
}

class EmergencyContact {
  final String name;
  final String contactNumber;

  EmergencyContact({
    required this.name,
    required this.contactNumber,
  });
}
