import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/shared/colors.dart';

class EventStatusChip extends StatelessWidget {
  final String eventStatus;

  const EventStatusChip({required this.eventStatus, super.key});

  Color getColor(String status) {
    if (status == "Finished") {
      return Colors.black;
    } else if (status == "Ongoing") {
      return const Color(0xffFF8C40);
    } else {
      return MyColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: getColor(eventStatus)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: getColor(eventStatus)),
          ),
          Text(
            eventStatus,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: getColor(eventStatus),
            ),
          ),
        ],
      ),
    );
  }
}
