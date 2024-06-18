import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/Schedule_list.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScheduleTab();
  }
}

class _ScheduleTab extends State<ScheduleTab> {
  final List<Schedule> _registerdSchedule = [
    Schedule(
      title: 'Hello',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Eos exercitationem sunt possimus? Unde iste optio aut, ab culpa commodi libero quam modi maxime harum reprehenderit deserunt, ut dolorum dolores autem.',
      speakerName: ['Ramu', 'Ramu'],
      timeStart: 9,
      timeEnd: 12,
    ),
    Schedule(
      title: 'Hello',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Eos exercitationem sunt possimus? Unde iste optio aut, ab culpa commodi libero quam modi maxime harum reprehenderit deserunt, ut dolorum dolores autem.',
      speakerName: ['Ramu', 'Ramu'],
      timeStart: 9,
      timeEnd: 12,
    ),
    Schedule(
      title: 'Hello',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Eos exercitationem sunt possimus? Unde iste optio aut, ab culpa commodi libero quam modi maxime harum reprehenderit deserunt, ut dolorum dolores autem.',
      speakerName: ['Ramu', 'Ramu'],
      timeStart: 9,
      timeEnd: 12,
    ),
    Schedule(
      title: 'Hello',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Eos exercitationem sunt possimus? Unde iste optio aut, ab culpa commodi libero quam modi maxime harum reprehenderit deserunt, ut dolorum dolores autem.',
      speakerName: ['Ramu', 'Ramu'],
      timeStart: 9,
      timeEnd: 12,
    ),
    Schedule(
      title: 'Hello',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Eos exercitationem sunt possimus? Unde iste optio aut, ab culpa commodi libero quam modi maxime harum reprehenderit deserunt, ut dolorum dolores autem.',
      speakerName: ['Ramu', 'Ramu'],
      timeStart: 9,
      timeEnd: 12,
    ),
    Schedule(
      title: 'Hello',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Eos exercitationem sunt possimus? Unde iste optio aut, ab culpa commodi libero quam modi maxime harum reprehenderit deserunt, ut dolorum dolores autem.',
      speakerName: ['Ramu', 'Ramu'],
      timeStart: 9,
      timeEnd: 12,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text("No Schedule found for today"));
    if (_registerdSchedule.isNotEmpty) {
      mainContent = SchedulesList(schedules: _registerdSchedule);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: const Text(
          'Time Table',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Row(children: [
            const SizedBox(width: 20),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
              child: const Text('Day 1'),
            ),
            const SizedBox(
              width: 4,
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
              child: const Text('Day 2'),
            )
          ]),
        ),
      ),
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: mainContent,
      ),
    );
  }
}
