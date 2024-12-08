import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contact,
  });

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final Uri phoneUri = Uri(scheme: 'tel', path: contact.phone);
            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri);
            } else {
              ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                const SnackBar(content: Text('Could not launch phone app')),
              );
            }
          },
          icon: Icon(Icons.call),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contact.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                contact.phone,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Consumer(builder: (context, ref, child) {
          final role = ref.read(userProvider)!.role;
          if (role != AdminRole.superAdmin && role != AdminRole.eventsVolunteer) {
            return const SizedBox();
          }
          return IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: const Text('Delete Contact'),
                    content:
                        Text('Are you sure you want to delete this contact - ${contact.name}?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          navigatorKey.currentState!.pop();
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await DataService.deleteContact(contact.phone);
                          navigatorKey.currentState!.pop();
                          showSnackBar(
                              'Deleted contact. Please reopen "Important Contacts" screen to see changes.');
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        }),
      ],
    );
  }
}
