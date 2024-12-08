import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/admin/add_contact_screen.dart';

import '../../widgets/profile_screen/contacts_section.dart';

class ImportantContacts extends StatefulWidget {
  const ImportantContacts({super.key});

  @override
  State<ImportantContacts> createState() => _ImportantContactsState();
}

class _ImportantContactsState extends State<ImportantContacts> {
  @override
  Widget build(BuildContext context) {
    Map<String, List<ContactModel>> allContacts = {};
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
              if (allContacts[e.category] == null) {
                allContacts[e.category] = [];
              } else {
                allContacts[e.category]!.add(e);
              }
            }
            final types = allContacts.keys.toList();
            return ListView(
              children: [
                ...allContacts.keys.map(
                  (key) => ContactsSection(
                    title: key,
                    contacts: allContacts[key] ?? [],
                    types: types,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No contacts found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => AddContactScreen(
                types: allContacts.keys.toList(),
              ),
            ),
          );
          setState(() {});
        },
        backgroundColor: MyColors.primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
