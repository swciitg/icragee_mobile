import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../models/emergency_contact.dart';

class ContactsWidget extends StatelessWidget {
  final List<EmergencyContact> contacts;

  const ContactsWidget({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.navBarBackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 90,
                  height: 30,
                ),
                Expanded(
                  child: Text(
                    'Contact No',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        contact.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 90,
                      height: 30,
                    ),
                    Expanded(
                      child: Text(
                        contact.contactNumber,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
