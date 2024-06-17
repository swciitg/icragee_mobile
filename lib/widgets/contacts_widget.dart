import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

class ContactsWidget extends StatelessWidget {
  final String title;
  final List<EmergencyContact> contacts;

  const ContactsWidget({
    Key? key,
    required this.title,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Column(
        children: [
          Container(
            color: MyColors.navBarBackgroundColor,
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 90,
                ),
                Expanded(
                  child: Text(
                    'Contact No',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  tileColor: MyColors.navBarBackgroundColor,
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
        ],
      ),
    );
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
