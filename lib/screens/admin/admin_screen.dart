import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/day_button.dart';
import '../../widgets/event_card.dart';
import '../../widgets/tab_button.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminScreen> {
  bool _eventsSelected = true;
  int _selectedDay = 1;
  final Map<int, bool> _expandedDescriptions = {};
  final DataService _dataService = DataService();
  List<Schedule> events = [];

  @override
  void initState() {
    super.initState();
  }

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
      'message': 'Faucibus purus in massa tempor. Egestas sed tempus urna et pharetra.'
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
    {
      'sender': 'Admn',
      'priority': 'Important',
      'time': '1 hour ago',
      'message':
          'Faucibus purus in massa tempor. Egestas sed tempus urna et pharetra. Porttitor rhoncus dolor purus non enim praesent.'
    },
    {
      'sender': 'Ad',
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
            padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Welcome Back !',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                GestureDetector(
                  child: Image.asset(
                    'assets/icons/Vector.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                style: TextStyle(color: MyColors.primaryTextColor, fontWeight: FontWeight.bold),
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<Schedule>>(
                future: _dataService.getUserEvents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No events found'));
                  } else {
                    List<Schedule> events = snapshot.data!;
                    List<Schedule> filteredEvents =
                        events.where((event) => event.day == _selectedDay).toList();

                    return Container(
                      decoration: const BoxDecoration(color: MyColors.backgroundColor),
                      child: ListView.builder(
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) {
                          final event = filteredEvents[index];
                          final uniqueKey = index;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                            child: EventCard(
                              event: event,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
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
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 43.5),
            child: Text(
              _eventsSelected ? 'Add Events' : 'Add Notifications',
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          backgroundColor: MyColors.primaryColor,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // Positioned in the middle at the bottom
    );
  }

  Widget _buildNotificationsPage() {
    return Expanded(
      child: Container(
        color: MyColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                                fontSize: 12,
                              ),
                            ),
                            if (notification['priority']!.isNotEmpty)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 2),
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Important',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(width: 2),
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
            },
          ),
        ),
      ),
    );
  }
}
