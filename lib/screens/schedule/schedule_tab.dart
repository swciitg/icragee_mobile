import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/widgets/schedule_item.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  int selectedDay = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC6FCED),
      appBar: AppBar(
        title: const Text('Time Table',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFC6FCED),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedDay = 1;
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      selectedDay == 1 ? Colors.white : const Color(0xFFC6FCED),
                  side: const BorderSide(color: Colors.black54, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Day 1',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedDay = 2;
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      selectedDay == 2 ? Colors.white : const Color(0xFFC6FCED),
                  side: const BorderSide(color: Colors.black54, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Day 2',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedDay = 3;
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      selectedDay == 3 ? Colors.white : const Color(0xFFC6FCED),
                  side: const BorderSide(color: Colors.black54, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Day 3',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Schedule>>(
              future: DataService.getSchedules(selectedDay),
              //future: dataService.getSchedules(selectedDay),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text('No schedules found for Day $selectedDay'));
                } else {
                  List<Schedule> schedules = snapshot.data!;
                  return ListView.separated(
                    itemCount: schedules.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) =>
                        ScheduleItem(schedule: schedules[index]),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
