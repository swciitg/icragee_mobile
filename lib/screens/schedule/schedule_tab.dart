import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
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
      backgroundColor: Color.fromARGB(255, 167, 227, 227),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time Table',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            Row(children: [
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
              const SizedBox( width: 4,),
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
            // const SizedBox(height: 4),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
