import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/lost_found_model.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LostOrFoundDetailsCard extends StatelessWidget {
  final LostFoundModel item;
  const LostOrFoundDetailsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.primaryColorTint,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(28, 28, 28, 0.2),
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Image.network(item.imageUrl),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${item.category == "lost" ? "Lost at: " : "Found at: "} ${item.location}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        final Uri phoneUri = Uri(scheme: 'tel', path: item.contact);
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                            const SnackBar(content: Text('Could not launch phone app')),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.phone,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Description: ${item.description}"),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('M-d-yyyy | hh:mm a').format(
                        DateTime.parse(item.submittedAt),
                      ),
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
