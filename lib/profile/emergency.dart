import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/contacts_widget.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  List<EmergencyContact> contacts = [
    EmergencyContact(name: 'E Rickshaw', contactNumber: ''),
    EmergencyContact(name: 'Dipankar Barua', contactNumber: '6001440472'),
    EmergencyContact(name: 'Krishna Rao', contactNumber: '7896513761'),
    EmergencyContact(name: 'Deepjyoti Kalita', contactNumber: '8486664356'),
    EmergencyContact(name: 'Pranav Tamuli', contactNumber: '8638112240'),
    EmergencyContact(name: 'Subhankar Das', contactNumber: '8822905061'),
    EmergencyContact(name: 'Dilip Das', contactNumber: '8954594983'),
    EmergencyContact(name: 'Khoka rentals', contactNumber: '8770024956'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
          padding: EdgeInsets.all(16),
          child: ContactsWidget(
            title: 'Emergency',
            contacts: contacts,
          )),
    );
  }
}
