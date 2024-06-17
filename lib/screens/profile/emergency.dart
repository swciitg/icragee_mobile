import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/contacts_widget.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
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

// Usage

    return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ContactsWidget(
            title: 'Emergency',
            contacts: contacts,
          ),
        ));
  }
}
