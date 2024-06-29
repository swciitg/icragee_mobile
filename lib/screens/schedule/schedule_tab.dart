import 'package:flutter/material.dart';

import '../../dataService.dart';
import '../../schedule.dart';

class ScheduleTab extends StatefulWidget {

  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  //const ScheduleTab({super.key});
  final DataService dataService = DataService();
  String selectedDay = 'Day 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC6FCED),
      appBar: AppBar(title: const Text('Time Table',style: TextStyle(fontWeight: FontWeight.bold)),backgroundColor: const Color(0xFFC6FCED),),
      body: Column(children: [
        Row(
          children: [
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  selectedDay = 'Day 1';
                });
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedDay == 'Day 1' ? Colors.white : Color(0xFFC6FCED),
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
                  selectedDay = 'Day 2';
                });
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedDay == 'Day 2' ? Colors.white : Color(0xFFC6FCED),
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
                  selectedDay = 'Day 3';
                });
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedDay == 'Day 3' ? Colors.white : Color(0xFFC6FCED),
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
          ],),
        const SizedBox(height: 16),
        Expanded(
          child: FutureBuilder<List<Schedule>>(
            future: dataService.getSchedules(selectedDay),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No schedules found for $selectedDay'));
              } else {
                List<Schedule> schedules = snapshot.data!;
                return ListView.separated(
                  itemCount: schedules.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    Schedule schedule = schedules[index];
                    // // DateTime scheduleDateTime = DateTime.parse("${schedule.date} ${schedule.time}");
                    // // DateTime now = DateTime.now();
                    // String status ='Ongoing';
                    // scheduleDateTime.isBefore(now) ? 'Ongoing' : 'Upcoming';
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        title: Text(schedule.title,style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Row(children: [
                          const Icon(Icons.schedule_outlined,size:17),
                          const SizedBox(width: 2),
                          Text(schedule.time,style: const TextStyle(fontWeight: FontWeight.w500,fontSize:10.2 )),
                          const SizedBox(width: 3),
                          const Icon(Icons.location_on_outlined,size:17),
                          Text(schedule.location,style: const TextStyle(fontWeight: FontWeight.w500,fontSize:10.2 ))],),
                        trailing: Column(
                            children: [const Icon(Icons.location_on,size:25),
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
                                  child:
                                  Text(
                                      schedule.status,
                                      style: const TextStyle
                                        (fontWeight: FontWeight.w600,
                                          fontSize:8.2,color:Colors.teal )
                                  )
                              )
                            ]),
                        tileColor: Colors.white,
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ],),
    );
  }
}

