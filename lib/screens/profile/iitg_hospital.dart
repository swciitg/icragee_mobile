import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../models/emergency_contact.dart';
import '../../widgets/contacts_widget.dart';

class IitgHospital extends StatelessWidget {
  const IitgHospital({super.key});

  @override
  Widget build(BuildContext context) {
    List<EmergencyContact> contacts = [
      EmergencyContact(name: 'Dmo', contactNumber: '3612582094'),
      EmergencyContact(name: 'Pharmacy', contactNumber: '3612582095'),
      EmergencyContact(name: 'Lab', contactNumber: '3612582096'),
      EmergencyContact(name: 'Midwife(Das I)', contactNumber: '3612582097'),
      EmergencyContact(name: 'ECG Room', contactNumber: '3612582098'),
      EmergencyContact(name: 'Reception', contactNumber: '3612582099'),
      EmergencyContact(name: 'Medical Office', contactNumber: '3612582100'),
      EmergencyContact(name: 'Nursing Station', contactNumber: '3612582101'),
      EmergencyContact(name: 'Doctors chamber', contactNumber: '3612582103'),
      EmergencyContact(
          name: 'Medical Supervisor room', contactNumber: '3612582987'),
      EmergencyContact(name: 'Room no 109', contactNumber: '3612582995'),
      EmergencyContact(
          name: 'Medical driver room', contactNumber: '3612583808'),
      EmergencyContact(
          name: 'Medical eye doctor room', contactNumber: '3612583810'),
      EmergencyContact(
          name: 'Medical dental room', contactNumber: '3612583812'),
      EmergencyContact(
          name: 'Medical nursing station', contactNumber: '3612583820'),
    ];
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
          child: Scrollbar(
            child: ContactsWidget(
              contacts: contacts,
            ),
          ),
        ));
  }
}
