import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:intl/intl.dart';

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
      body: SingleChildScrollView(
        child: Padding(
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
                  InkWell(onTap: () {}, child: Icon(Icons.arrow_forward)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTabButton('Events', _eventsSelected, () {
                      setState(() {
                        _eventsSelected = true;
                      });
                    }),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child:
                        _buildTabButton('Notification', !_eventsSelected, () {
                      setState(() {
                        _eventsSelected = false;
                      });
                    }),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Click here to view feedbacks',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (_eventsSelected) ...[
                Row(
                  children: [
                    _buildDayButton('Day 1', 1),
                    SizedBox(width: 10),
                    _buildDayButton('Day 2', 2),
                    SizedBox(width: 10),
                    _buildDayButton('Day 3', 3),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true, // This allows ListView to wrap its content
                  physics:
                      NeverScrollableScrollPhysics(), // Disable ListView scrolling
                  itemCount:
                      events.where((event) => event.day == _selectedDay).length,
                  itemBuilder: (context, index) {
                    return _buildEventCard(
                        index,
                        events
                            .where((event) => event.day == _selectedDay)
                            .elementAt(index));
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Add Events'),
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
      ),
    );
  }

  Widget _buildNotificationsPage() {
    return Column(
      children: notifications.map((notification) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      notification['time']!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                if (notification['priority']!.isNotEmpty)
                  Chip(
                    label: Text('Important'),
                    labelStyle: TextStyle(color: Colors.red),
                    backgroundColor: Colors.red.withOpacity(0.2),
                  ),
                SizedBox(height: 8),
                Text(notification['message']!),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDayButton(String day, int dayNumber) {
    bool isSelected = _selectedDay == dayNumber;
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedDay = dayNumber;
        });
      },
      child: Text(day),
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? MyColors.primaryColor : MyColors.backgroundColor,
        foregroundColor: isSelected ? Colors.white : MyColors.primaryColor,
        side: BorderSide(color: Colors.teal),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildEventCard(int index, Schedule event) {
    bool isExpanded = _expandedDescriptions[index] ?? false;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(event.title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                _buildStatusChip(event.status),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text(
                    '${DateFormat('kk:mm').format(event.startTime.toLocal())}'
                    ' - ${DateFormat('kk:mm').format(event.endTime.toLocal())}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 13)),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text(
                  event.location,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  _expandedDescriptions[index] = !isExpanded;
                });
              },
              child: Text(
                'Check Description',
                style: TextStyle(
                    color: Colors.teal, decoration: TextDecoration.underline),
              ),
            ),
            if (isExpanded) ...[
              SizedBox(height: 8),
              Text(event.description),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'finished':
        color = Colors.grey;
        break;
      case 'ongoing':
        color = Colors.orange;
        break;
      case 'upcoming':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }
    return Chip(
      label: Text(status),
      // backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? MyColors.primaryColor : MyColors.backgroundColor,
        foregroundColor: isSelected ? Colors.white : MyColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
