import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/admin/event_card.dart';
import 'package:icragee_mobile/widgets/admin/notifications_page.dart';
import 'package:icragee_mobile/widgets/day_button.dart';
import 'package:icragee_mobile/widgets/tab_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    FirebaseMessaging.instance.unsubscribeFromTopic('All');
  }

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
                      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Welcome Back!',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  navigatorKey.currentContext!.push('/qr-scanner');
                                },
                                child: const Icon(
                                  Icons.qr_code_scanner_rounded,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () async {
                                  final prefs = await SharedPreferences.getInstance();
                                  prefs.clear();
                                  while (navigatorKey.currentContext!.canPop()) {
                                    navigatorKey.currentContext!.pop();
                                  }
                                  navigatorKey.currentContext!.push("/get-started");
                                },
                                child: const Icon(
                                  Icons.logout_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 25),
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
                              const SizedBox(width: 10),
                              DayButton(
                                dayNumber: 4,
                                selectedDay: _selectedDay,
                                onPressed: (dayNumber) {
                                  setState(() {
                                    _selectedDay = dayNumber;
                                  });
                                },
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
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
                            child: const Center(child: Text('No events found')));
                      } else {
                        List<Event> events = snapshot.data!;
                        return Container(
                          decoration: const BoxDecoration(color: MyColors.backgroundColor),
                          child: ListView.builder(
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(15, index == 0 ? 15 : 0, 15,
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
                const SizedBox(height: 10),
                // Notifications Page UI
                const Expanded(
                  child: SingleChildScrollView(child: NotificationsPage()),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_eventsSelected) {
            await context.push('/addEventScreen');
            setState(() {});
          } else {
            context.push('/addNotificationScreen');
          }
        },
        label: Text(
          _eventsSelected ? 'Add Event' : 'Add Notification',
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
}
