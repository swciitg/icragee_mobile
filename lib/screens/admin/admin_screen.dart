import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/day_button.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome Back !',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Spacer(),
                Expanded(
                  child: GestureDetector(
                    child: Image.asset(
                      'assets/icons/Vector.png',
                      height: 24.0,
                      width: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
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
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: const Text(
                'Click here to view feedbacks',
                style: TextStyle(
                    color: MyColors.primaryTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_eventsSelected) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: MyColors.backgroundColor),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      events.where((event) => event.day == _selectedDay).length,
                  itemBuilder: (context, index) {
                    final filteredEvents = events
                        .where((event) => event.day == _selectedDay)
                        .toList();
                    final event = filteredEvents[index];

                    // Create a unique key for each event
                    final uniqueKey = index;

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      child: EventCard(
                        event: event,
                        isExpanded: _expandedDescriptions[uniqueKey] ?? false,
                        onToggleDescription: () {
                          setState(() {
                            _expandedDescriptions[uniqueKey] =
                                !(_expandedDescriptions[uniqueKey] ?? false);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 46,
              child: Container(
                decoration: BoxDecoration(color: MyColors.backgroundColor),
              ),
            )
          ] else ...[
            // Notifications Page UI
            _buildNotificationsPage(),
          ],
        ],
      ),

      floatingActionButton: SizedBox(
        width: 180,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_eventsSelected) {
              // Action to add an event
            } else {
              // Action to add a notification
            }
          },
          label: Text(
            _eventsSelected ? 'Add Events' : 'Add Notifications',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          backgroundColor: MyColors.primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // Positioned in the middle at the bottom
    );
  }

  Widget _buildNotificationsPage() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: MyColors.backgroundColor),
        child: Column(
          children: notifications.map((notification) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification['sender']!,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          if (notification['priority']!.isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 2,
                                  ),

                                  Container(
                                    width: 8, // Width of the dot
                                    height: 8, // Height of the dot
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          4), // Space between the dot and text
                                  Text(
                                    'Important',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  )
                                ],
                              ),
                            ),
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
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
