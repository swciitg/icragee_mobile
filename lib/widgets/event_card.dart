import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/widgets/status_chip.dart';
import 'package:intl/intl.dart';

import '../screens/edit_event_screen.dart';
import '../shared/globals.dart';

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late Timer _timer;
  bool _isExpanded = false;

  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = _getEventStatus();
    // Update status every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _currentStatus = _getEventStatus();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getEventStatus() {
    final now = DateTime.now();
    final currDate = dayOneDate.add(Duration(days: widget.event.day - 1));

    final eventStart = currDate.copyWith(
        hour: widget.event.startTime.hour,
        minute: widget.event.startTime.minute);

    final eventEnd = currDate.copyWith(
        hour: widget.event.endTime.hour, minute: widget.event.endTime.minute);

    if (now.isBefore(eventStart)) {
      return 'Upcoming';
    } else if (now.isAfter(eventStart) && now.isBefore(eventEnd)) {
      return 'Ongoing';
    } else {
      return 'Finished';
    }
  }

  // Delete event from Firestore
  Future<void> _deleteEvent() async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.event.id) // Assuming event has an 'id' field
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete event: $e')),
      );
    }
  }

  void _toggleDescription() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                StatusChip(status: _currentStatus),
              ],
            ),

            // Time and Location
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${DateFormat('hh:mm a').format(widget.event.startTime.toLocal())}'
                      ' - ${DateFormat('hh:mm a').format(widget.event.endTime.toLocal())}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      widget.event.venue,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),

            // Check Description button
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Center(
                child: GestureDetector(
                  onTap: _toggleDescription,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Check Description',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.teal,
                            decoration: TextDecoration.underline),
                      ),
                      const SizedBox(width: 2),
                      Image.asset(
                        "assets/icons/check_description.png",
                        height: 18,
                        width: 18,
                        color: Colors.teal,
                      ),
                      const SizedBox(width: 130),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Edit Event') {
                            // Navigate to the Edit Event Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditEventScreen(
                                  event: widget.event,
                                ),
                              ),
                            );
                          } else if (value == 'Delete Event') {
                            // Call delete event function
                            _deleteEvent();
                          }
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
                ),
              ),
            ),

            // Description Text if expanded
            if (_isExpanded) ...[
              const SizedBox(height: 8),
              Text(widget.event.description),
            ],
          ],
        ),
      ),
    );
  }
}
