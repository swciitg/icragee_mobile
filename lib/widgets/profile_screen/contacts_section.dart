import 'dart:math';

import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/profile/all_contacts_list.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/profile_screen/contact_card.dart';

import '../../models/contact_model.dart';

class ContactsSection extends StatelessWidget {
  final String title;
  final List<ContactModel> contacts;
  final int length;

  const ContactsSection({
    super.key,
    required this.title,
    required this.contacts,
    this.length = 5,
  });

  @override
  Widget build(BuildContext context) {
    if (this.contacts.isEmpty) return const SizedBox();
    final contacts =
        this.contacts.sublist(0, min(length, this.contacts.length));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.backgroundColor),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AllContactsList(
                              title: title, contacts: this.contacts),
                        ),
                      );
                    },
                    child: const Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16).copyWith(bottom: 0, top: 8),
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
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ContactCard(contact: contact);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
