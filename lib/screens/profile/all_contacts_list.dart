import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/admin/add_contact_screen.dart';
import 'package:icragee_mobile/widgets/profile_screen/contact_card.dart';

class AllContactsList extends StatelessWidget {
  final String title;
  final List<String> types;
  final List<ContactModel> contacts;

  const AllContactsList({
    super.key,
    required this.title,
    required this.contacts,
    required this.types,
  });

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
          title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: MyColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16).copyWith(bottom: 8, top: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: MyColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contacts.map((contact) => ContactCard(contact: contact)).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => AddContactScreen(types: types),
            ),
          );
        },
        backgroundColor: MyColors.primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
