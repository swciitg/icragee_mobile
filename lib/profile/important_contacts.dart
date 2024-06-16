import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/profile/emergency.dart';
import 'package:icragee_mobile/screens/profile/iitg_hospital.dart';
import 'package:icragee_mobile/screens/profile/profile_page.dart';
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
        title: Text('Important Contacts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36),
              ListTile(
                tileColor: MyColors.primaryColor,
                title: Text('Emergency'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Emergency()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                tileColor: MyColors.primaryColor,
                title: Text('IITG Hospital'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IitgHospital()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                tileColor: MyColors.primaryColor,
                title: Text('Transport'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Transport()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
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
