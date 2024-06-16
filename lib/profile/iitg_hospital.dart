import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/contacts_widget.dart';

class IitgHospital extends StatefulWidget {
  const IitgHospital({super.key});

  @override
  State<IitgHospital> createState() => _IitgHospitalState();
}

class _IitgHospitalState extends State<IitgHospital> {
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
    EmergencyContact(name: 'Medical driver room', contactNumber: '3612583808'),
    EmergencyContact(
        name: 'Medical eye doctor room', contactNumber: '3612583810'),
    EmergencyContact(name: 'Medical dental room', contactNumber: '3612583812'),
    EmergencyContact(
        name: 'Medical nursing station', contactNumber: '3612583820'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Scrollbar(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: ContactsWidget(
              title: 'IITG Hospital',
              contacts: contacts,
            )),
      ),
    );
  }
}
