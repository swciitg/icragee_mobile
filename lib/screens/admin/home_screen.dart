import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/build_day_button.dart';
import '../../widgets/event_card.dart';
import '../../widgets/tab_button.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminScreen> {
  bool _eventsSelected = true;
  int _selectedDay = 1;
  Map<int, bool> _expandedDescriptions = {};

  final List<Schedule> events = [
    Schedule(
      title: "Cement Preparation Workshop",
      startTime: DateTime(2024, 07, 1, 0),
      endTime: DateTime(2024, 07, 2, 0),
      location: "Auditorium",
      description: "Day 1 description...",
      day: 1,
      status: "Finished",
    ),
    Schedule(
      title: "Concrete Mixing Seminar",
      startTime: DateTime(2024, 07, 1, 0),
      endTime: DateTime(2024, 07, 2, 0),
      location: "Room 201",
      status: "Ongoing",
      description: "Day 2 description...",
      day: 1,
    ),
    Schedule(
      title: "Construction Safety Training",
      startTime: DateTime(2024, 07, 1, 0),
      endTime: DateTime(2024, 07, 2, 0),
      location: "Hall B",
      status: "Upcoming",
      description: "Day 3 description...",
      day: 1,
    ),
    Schedule(
      title: "Cement Preparation ",
      startTime: DateTime(2024, 07, 1, 0),
      endTime: DateTime(2024, 07, 2, 0),
      location: "Auditorium",
      description: "Day 1 description...",
      day: 1,
      status: "Finished",
    ),
    Schedule(
      title: "Cement",
      startTime: DateTime(2024, 07, 1, 0),
      endTime: DateTime(2024, 07, 2, 0),
      location: "Auditorium",
      description: "Day 1 description...",
      day: 2,
      status: "Finished",
    ),
    Schedule(
      title: "AutoCAD",
      startTime: DateTime(2024, 07, 1, 0),
      endTime: DateTime(2024, 07, 2, 0),
      location: "Auditorium",
      description: "Day 1 description...",
      day: 3,
      status: "Finished",
    ),
  ];

  final List<Map<String, String>> notifications = [
    {
      'sender': 'Prof. Sharma',
      'priority': 'Important',
      'time': 'Just now',
      'message': 'Faucibus purus in massa tempor.'
    },
    {
      'sender': 'Dr Prakash',
      'priority': 'Important',
      'time': '10 minutes ago',
      'message':
          'Faucibus purus in massa tempor. Egestas sed tempus urna et pharetra.'
    },
    {
      'sender': 'Co-Ordinator',
      'priority': '',
      'time': '1 hour ago',
      'message':
          'Faucibus purus in massa tempor. Egestas sed tempus urna et pharetra. Porttitor rhoncus dolor purus non enim praesent.'
    },
    {
      'sender': 'Admin',
      'priority': 'Important',
      'time': '1 hour ago',
      'message':
          'Faucibus purus in massa tempor. Egestas sed tempus urna et pharetra. Porttitor rhoncus dolor purus non enim praesent.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Welcome Back !',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                InkWell(onTap: () {}, child: const Icon(Icons.arrow_forward)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TabButton(
                    text: 'Events',
                    isSelected: _eventsSelected,
                    onPressed: () {
                      setState(() {
                        _eventsSelected = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TabButton(
                    text: 'Notification',
                    isSelected: !_eventsSelected,
                    onPressed: () {
                      setState(() {
                        _eventsSelected = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: const Text(
                  'Click here to view feedbacks',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (_eventsSelected) ...[
              Row(
                children: [
                  DayButton(
                    dayNumber: 1,
                    selectedDay: _selectedDay,
                    onPressed: (dayNumber) {
                      setState(() {
                        _selectedDay = dayNumber;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  DayButton(
                    dayNumber: 2,
                    onPressed: (dayNumber) {
                      setState(() {
                        _selectedDay = dayNumber;
                      });
                    },
                    selectedDay: _selectedDay,
                  ),
                  const SizedBox(width: 10),
                  DayButton(
                    dayNumber: 3,
                    selectedDay: _selectedDay,
                    onPressed: (dayNumber) {
                      setState(() {
                        _selectedDay = dayNumber;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      events.where((event) => event.day == _selectedDay).length,
                  itemBuilder: (context, index) {
                    final filteredEvents = events
                        .where((event) => event.day == _selectedDay)
                        .toList();
                    final event = filteredEvents[index];
                    // final event = events
                    //     .where((event) => event.day == _selectedDay)
                    //     .toList()[index];
                    return EventCard(
                      event: event,
                      isExpanded: _expandedDescriptions[event.day] ?? false,
                      onToggleDescription: () {
                        setState(() {
                          _expandedDescriptions[event.day] =
                              !(_expandedDescriptions[event.day] ?? false);
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add Events'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ] else ...[
              // Notifications Page UI
              _buildNotificationsPage(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsPage() {
    return Column(
      children: notifications.map((notification) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification['sender']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    if (notification['priority']!.isNotEmpty)
                      Chip(
                        label: Text('Important'),
                        labelStyle: TextStyle(color: Colors.red),
                        backgroundColor: Colors.red.withOpacity(0.2),
                      ),
                    const SizedBox(width: 40),
                    Text(
                      notification['time']!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(notification['message']!),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
