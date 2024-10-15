import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/utility/functions.dart';
import 'package:icragee_mobile/widgets/event_status_chip.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:intl/intl.dart';

import '../screens/edit_event_screen.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final Function() onChange;

  const EventCard({
    super.key,
    required this.onChange,
    required this.event,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  // bool _isExpanded = false;

  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = _getEventStatus();
  }

  String _getEventStatus() {
    final now = DateTime.now();
    final eventStart =
        getActualEventTime(widget.event.startTime, widget.event.day);
    final eventEnd = getActualEventTime(widget.event.endTime, widget.event.day);

    if (now.isBefore(eventStart)) {
      return 'Upcoming';
    } else if (now.isAfter(eventStart) && now.isBefore(eventEnd)) {
      return 'Ongoing';
    } else {
      return 'Finished';
    }
  }

  // void _toggleDescription() {
  //   setState(() {
  //     _isExpanded = !_isExpanded;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(28, 28, 28, 0.2),
            offset: Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.event.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.visible,
                  ),
                ),
                EventStatusChip(eventStatus: _currentStatus),
              ],
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ),
                    Expanded(child: Container()),
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'Edit Event') {
                          // Navigate to the Edit Event Screen
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditEventScreen(
                                event: widget.event,
                              ),
                            ),
                          );
                        } else if (value == 'Delete Event') {
                          try {
                            await DataService.deleteEvent(widget.event.id);
                            showSnackBar('Event deleted successfully!');
                          } catch (e) {
                            showSnackBar('Some error occurred!');
                          }
                        }
                        widget.onChange();
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'Edit Event',
                          child: Text('Edit Event'),
                        ),
                        const PopupMenuItem(
                          value: 'Delete Event',
                          child: Text('Delete Event'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ],
            ),
            if (widget.event.description.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 10),
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
      ),
    );
  }
}

class IconLabel extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconLabel({required this.text, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
