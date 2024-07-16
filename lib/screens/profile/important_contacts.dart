import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/profile/emergency.dart';
import 'package:icragee_mobile/screens/profile/iitg_hospital.dart';
import 'package:icragee_mobile/screens/profile/transport.dart';
import 'package:icragee_mobile/shared/colors.dart';

class ImportantContacts extends StatefulWidget {
  const ImportantContacts({super.key});

  @override
  State<ImportantContacts> createState() => _ImportantContactsState();
}

class _ImportantContactsState extends State<ImportantContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Important Contacts'),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.navBarBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Emergency'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const EmergencyContactsPage()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('IITG Hospital'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IitgHospital()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Transport'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Transport()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
