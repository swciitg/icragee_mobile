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
                    event.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.visible,
                  ),
                ),
                StatusChip(status: event.status),
              ],
            ),

            // Time and Location based on expansion
            if (isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${DateFormat('kk:mm').format(event.startTime.toLocal())}'
                        ' - ${DateFormat('kk:mm').format(event.endTime.toLocal())}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        event.location,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${DateFormat('kk:mm').format(event.startTime.toLocal())}'
                        ' - ${DateFormat('kk:mm').format(event.endTime.toLocal())}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        event.location,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),

            // Check Description button
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Center(
                child: GestureDetector(
                  onTap: onToggleDescription,
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
                      SizedBox(
                        width: 2,
                      ),
                      Image.asset(
                        "assets/icons/check_description.png",
                        height: 18,
                        width: 18,
                        color: Colors.teal,
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Description Text if expanded
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(event.description),
            ],
          ],
        ),
      ),
    );
  }
}
