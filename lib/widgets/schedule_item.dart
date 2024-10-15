import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/assets.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/utility/functions.dart';
import 'package:icragee_mobile/widgets/event_card.dart';
import 'package:icragee_mobile/widgets/event_status_chip.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:intl/intl.dart';

class EventScheduleTile extends StatefulWidget {
  final Event event;

  const EventScheduleTile({required this.event, super.key});

  @override
  State<EventScheduleTile> createState() => _EventScheduleTileState();
}

class _EventScheduleTileState extends State<EventScheduleTile> {
  var showDescription = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.event.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: _buildStatus(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconLabel(
                    text:
                        '${DateFormat('hh:mm a').format(widget.event.startTime.toLocal())}'
                        ' - ${DateFormat('hh:mm a').format(widget.event.endTime.toLocal())}',
                    icon: Icons.schedule_outlined,
                  ),
                  const SizedBox(height: 4),
                  IconLabel(
                    text: widget.event.venue,
                    icon: Icons.location_on_outlined,
                  ),
                ],
              ),
              GestureDetector(
                onTap: addEventToUser,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColorTint,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(MyIcons.addToList),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       showDescription = !showDescription;
              //     });
              //   },
              //   child: Row(
              //     children: [
              //       Text(
              //         "Check description",
              //         style: GoogleFonts.poppins(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w300,
              //           color: MyColors.primaryColor,
              //         ),
              //       ),
              //       const SizedBox(width: 6),
              //       Transform.rotate(
              //           angle: showDescription ? pi : 0,
              //           child: SvgPicture.asset(MyIcons.toggleDown, height: 18))
              //     ],
              //   ),
              // ),
            ],
          ),
          if (widget.event.description.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 12),
              child: Text(
                widget.event.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff1C1C1C),
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         color: MyColors.primaryColorTint,
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       child: SvgPicture.asset(MyIcons.location),
          //     ),
          //
          //   ],
          // )
        ],
      ),
    );
  }

  void addEventToUser() async {
    try {
      // TODO: remove email hardcoding
      await DataService.addEventToUser(
        "venkylm10@gmail.com",
        widget.event.id,
      );
      await FirebaseMessaging.instance.subscribeToTopic(widget.event.id);
      debugPrint("Subscribed to topic: ${widget.event.id}");
      showSnackBar("Added to your schedule");
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar("Failed to add to your schedule");
    }
  }

  Widget _buildStatus() {
    var status = "";
    final startTime =
        getActualEventTime(widget.event.startTime, widget.event.day);
    final endTime = getActualEventTime(widget.event.endTime, widget.event.day);
    if (endTime.isBefore(DateTime.now())) {
      status = "Finished";
    } else if (startTime.isBefore(DateTime.now()) &&
        endTime.isAfter(DateTime.now())) {
      status = "Ongoing";
    } else {
      status = "Upcoming";
    }
    return EventStatusChip(eventStatus: status);
  }
}
