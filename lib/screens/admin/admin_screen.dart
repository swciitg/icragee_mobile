import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/models/event.dart';
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
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
  }

  List<Map<String, String>> notifications = [
    {
      'title': 'Event Reminder',
      'message': 'Don\'t forget to attend the annual tech conference tomorrow!',
      'time': '2024-10-16 09:00 AM',
    },
    {
      'title': 'Workshop Registration',
      'message': 'Your spot is confirmed for the Flutter workshop today.',
      'time': '2024-10-16 11:00 AM',
    },
    {
      'title': 'Session Starting Soon',
      'message': 'The keynote session will start in 30 minutes. Join us!',
      'time': '2024-10-16 01:30 PM',
    },
    {
      'title': 'Networking Event',
      'message':
          'The networking event is starting at the main hall. See you there!',
      'time': '2024-10-16 03:00 PM',
    },
    {
      'title': 'Event Survey',
      'message':
          'Please take a moment to fill out the event survey. Your feedback matters!',
      'time': '2024-10-16 05:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SafeArea(
        child: Container(
          color: MyColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 20, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Welcome Back!',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.black,
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
                    const SizedBox(height: 15),
                    // TODO: Uncomment it after DB Integration
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 20),
                    //   child: Align(
                    //     alignment: Alignment.center,
                    //     child: InkWell(
                    //       onTap: () {},
                    //       child: const Text(
                    //         'Click here to view feedbacks',
                    //         style: TextStyle(
                    //             color: MyColors.primaryTextColor,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    if (_eventsSelected)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
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
                      ),
                  ],
                ),
              ),
              if (_eventsSelected) ...[
                Expanded(
                  child: FutureBuilder<List<Event>>(
                    future: DataService.getDayWiseEvents(_selectedDay),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            color: MyColors.backgroundColor,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: MyColors.primaryColor,
                            )));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Container(
                            color: MyColors.backgroundColor,
                            child:
                                const Center(child: Text('No events found')));
                      } else {
                        List<Event> events = snapshot.data!;
                        return Container(
                          decoration: const BoxDecoration(
                              color: MyColors.backgroundColor),
                          child: ListView.builder(
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    15,
                                    index == 0 ? 15 : 0,
                                    15,
                                    index == events.length - 1 ? 100 : 12),
                                child: EventCard(
                                    event: events[index],
                                    onChange: () {
                                      setState(() {});
                                    }),
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
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_eventsSelected) {
            context.push('/addEventScreen');
          } else {
            // Action to add a notification
          }
        },
        label: Text(
          _eventsSelected ? 'Add Events' : 'Add Notifications',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: MyColors.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildNotificationsPage() {
    return Expanded(
      child: Container(
        color: MyColors.backgroundColor,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Padding(
              padding: EdgeInsets.fromLTRB(15, index == 0 ? 15 : 0, 15,
                  index == notifications.length - 1 ? 100 : 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(28, 28, 28, 0.2),
                      offset: Offset(0, 4),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
                ),
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
                            notification['title']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
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
    );
  }
}
