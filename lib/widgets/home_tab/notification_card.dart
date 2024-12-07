import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.noti,
    required this.timeAgo,
  });

  final NotificationModel noti;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                noti.title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )),
              const SizedBox(width: 8),
              if (noti.important)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.red,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Important",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff1C1C1C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Text(
                timeAgo,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            noti.description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff1C1C1C),
            ),
          ),
        ],
      ),
    );
  }
}
