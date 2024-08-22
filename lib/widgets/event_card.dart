import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/widgets/status_chip.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Schedule event;
  final bool isExpanded;
  final VoidCallback onToggleDescription;

  const EventCard({
    Key? key,
    required this.event,
    required this.isExpanded,
    required this.onToggleDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(event.title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                StatusChip(status: event.status),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text(
                    '${DateFormat('kk:mm').format(event.startTime.toLocal())}'
                    ' - ${DateFormat('kk:mm').format(event.endTime.toLocal())}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 13)),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text(event.location),
              ],
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: onToggleDescription,
              child: Text(
                'Check Description',
                style: TextStyle(
                    color: Colors.teal, decoration: TextDecoration.underline),
              ),
            ),
            if (isExpanded) ...[
              SizedBox(height: 8),
              Text(event.description),
            ],
          ],
        ),
      ),
    );
  }
}
