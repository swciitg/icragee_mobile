import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;

  const ScheduleItem({required this.schedule, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        title: Text(schedule.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            const Icon(Icons.schedule_outlined, size: 17),
            const SizedBox(width: 2),
            Text(
                '${DateFormat('kk:mm').format(schedule.startTime.toLocal())}'
                ' - ${DateFormat('kk:mm').format(schedule.endTime.toLocal())}',
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 10.2)),
            const SizedBox(width: 3),
            const Icon(Icons.location_on_outlined, size: 17),
            Text(schedule.location,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 10.2))
          ],
        ),
        trailing: Column(children: [
          const Icon(Icons.location_on, size: 25),
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(
                left: 5.0,
                top: 1.0,
                right: 1.0,
                bottom: 2.0,
              ),
              child: Text(
                  (DateTime.now().isAfter(schedule.startTime) &&
                          DateTime.now().isBefore(schedule.endTime))
                      ? 'Ongoing'
                      : (DateTime.now().isBefore(schedule.startTime)
                          ? 'Upcoming'
                          : 'Completed'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 8.2,
                      color: Colors.teal)))
        ]),
        tileColor: Colors.white,
      ),
    );
  }
}
