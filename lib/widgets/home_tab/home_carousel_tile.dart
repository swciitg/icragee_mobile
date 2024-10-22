import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/admin/event_card.dart';
import 'package:intl/intl.dart';

class HomeCarouselTile extends StatefulWidget {
  final Event event;

  const HomeCarouselTile({
    super.key,
    required this.event,
  });

  @override
  State<HomeCarouselTile> createState() => _HomeCarouselTileState();
}

class _HomeCarouselTileState extends State<HomeCarouselTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 24,
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 20),
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(28, 28, 28, 0.2),
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event.title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          IconLabel(
              text:
                  '${DateFormat('hh:mm a').format(widget.event.startTime.toLocal())}'
                  ' - ${DateFormat('hh:mm a').format(widget.event.endTime.toLocal())}',
              icon: Icons.access_time),
          const SizedBox(height: 8),
          IconLabel(
            text: widget.event.venue,
            icon: Icons.location_on,
          ),
          const SizedBox(height: 10),
          Expanded(child: Container()),
          Text(
            widget.event.description,
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
