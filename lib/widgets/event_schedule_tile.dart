import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/utility/functions.dart';
import 'package:icragee_mobile/widgets/admin/event_card.dart';
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
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(28, 28, 28, 0.2),
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
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
              Consumer(builder: (context, ref, child) {
                final user = ref.watch(userProvider)!;
                if (user.eventList?.contains(widget.event.id) ?? false) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.notifications_active,
                      color: MyColors.primaryColor,
                    ),
                  );
                }
                return const SizedBox();
              }),
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
                    text: '${DateFormat('hh:mm a').format(widget.event.startTime.toLocal())}'
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
              _buildPopupMenuButton(),
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
        ],
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return Consumer(builder: (context, ref, child) {
      final user = ref.watch(userProvider)!;
      final email = user.email;
      final inList = user.eventList?.contains(widget.event.id) ?? false;
      return PopupMenuButton<String>(
        onSelected: (value) async {
          if (value == 'notify') {
            await addEventToUser(email);
            ref.read(userProvider.notifier).updateUserDetails();
          } else if (value == 'un-notify') {
            await removeEventFromUser(email);
            ref.read(userProvider.notifier).updateUserDetails();
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            if (!inList)
              PopupMenuItem(
                value: 'notify',
                child: Row(
                  children: [
                    Icon(Icons.notifications),
                    const SizedBox(width: 8),
                    Text('Notify Me'),
                  ],
                ),
              ),
            if (inList)
              PopupMenuItem(
                value: 'un-notify',
                child: Row(
                  children: [
                    Icon(Icons.notifications_off_rounded),
                    const SizedBox(width: 8),
                    Text("Un-Notify")
                  ],
                ),
              )
          ];
        },
        icon: Icon(
          Icons.more_vert,
          color: MyColors.primaryColor,
        ),
      );
    });
  }

  Future<void> addEventToUser(String email) async {
    try {
      await DataService.addEventToUser(
        email,
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

  Future<void> removeEventFromUser(String email) async {
    try {
      await DataService.removeEventFromUser(
        email,
        widget.event.id,
      );
      await FirebaseMessaging.instance.unsubscribeFromTopic(widget.event.id);
      debugPrint("Unsubscribed from topic: ${widget.event.id}");
      showSnackBar("Removed from your schedule");
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar("Failed to remove from your schedule");
    }
  }

  Widget _buildStatus() {
    var status = "";
    final startTime = getActualEventTime(widget.event.startTime, widget.event.day);
    final endTime = getActualEventTime(widget.event.endTime, widget.event.day);
    if (endTime.isBefore(DateTime.now())) {
      status = "Finished";
    } else if (startTime.isBefore(DateTime.now()) && endTime.isAfter(DateTime.now())) {
      status = "Ongoing";
    } else {
      status = "Upcoming";
    }
    return EventStatusChip(eventStatus: status);
  }
}
