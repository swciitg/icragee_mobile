import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/profile_screen/contacts_section.dart';

class ImportantContacts extends StatefulWidget {
  const ImportantContacts({super.key});

  @override
  State<ImportantContacts> createState() => _ImportantContactsState();
}

class _ImportantContactsState extends State<ImportantContacts> {
  List<ContactModel> organizingCommittee = [];
  List<ContactModel> iitgHospital = [];
  List<ContactModel> transport = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: MyColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: MyColors.whiteColor,
          ),
        ),
        title: Text(
          "Important Contacts",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: MyColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder<List<ContactModel>>(
        future: DataService.fetchImportantContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            for (var e in snapshot.data!) {
              if (e.category == 'organizingCommittee') {
                organizingCommittee.add(e);
              } else if (e.category == 'iitgHospital') {
                iitgHospital.add(e);
              } else if (e.category == 'transport') {
                transport.add(e);
              }
            }
            return ListView(
              children: [
                ContactsSection(
                  title: 'Organizing Committee',
                  contacts: organizingCommittee,
                ),
                ContactsSection(
                  title: 'IITG Hospital',
                  contacts: iitgHospital,
                ),
                ContactsSection(
                  title: 'Transport',
                  contacts: transport,
                ),
              ],
            );
          } else {
            return const Center(child: Text('No contacts found.'));
          }
        },
      ),
    );
  }
}
