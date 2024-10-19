import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contact,
    required this.last,
  });

  final ContactModel contact;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        final Uri phoneUri = Uri(scheme: 'tel', path: contact.phone);
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri);
        } else {
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            const SnackBar(content: Text('Could not launch phone app')),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contact.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            contact.phone,
            style: const TextStyle(fontSize: 14),
          ),
          if (!last) const SizedBox(height: 8),
        ],
      ),
    );
  }
}
