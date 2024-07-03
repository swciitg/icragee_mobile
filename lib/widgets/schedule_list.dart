import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/widgets/schedule_item.dart';

class SchedulesList extends StatelessWidget {
  const SchedulesList({
    super.key,
    required this.schedules,
  });

  final List<Schedule> schedules;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (ctx, index) {
          return ScheduleItem(schedule: schedules[index]);
        });
  }
}
