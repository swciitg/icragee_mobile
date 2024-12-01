import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/screens/profile/profile_page.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/admin/event_card.dart';
import 'package:icragee_mobile/widgets/admin/notifications_page.dart';
import 'package:icragee_mobile/widgets/day_button.dart';
import 'package:icragee_mobile/widgets/tab_button.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState<AdminScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<AdminScreen> {
  bool _eventsSelected = true;
  int _selectedDay = 1;
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.unsubscribeFromTopic('All');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).updateIfSuperUser();
    });
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
                    _appBar(),
                    const SizedBox(height: 16),
                    _tabs(),
                    const SizedBox(height: 18),
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
                    _buildDayTabs(),
                  ],
                ),
              ),
              _eventsSelected ? _buildEvents() : _buildNotifications(),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final superUser = ref.watch(userProvider)!.superUser;
          if (!superUser) return const SizedBox();
          return FloatingActionButton.extended(
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
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildNotifications() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: NotificationsPage(),
      ),
    );
  }

  Widget _buildDayTabs() {
    if (!_eventsSelected) return const SizedBox();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const SizedBox(width: 16),
          ...List.generate(
            (4),
            (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DayButton(
                  dayNumber: index + 1,
                  selectedDay: _selectedDay,
                  onPressed: (dayNumber) {
                    setState(() {
                      _selectedDay = dayNumber;
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildEvents() {
    return Expanded(
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
                    padding: EdgeInsets.fromLTRB(
                        15, index == 0 ? 15 : 0, 15, index == events.length - 1 ? 100 : 12),
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
    );
  }

  Padding _tabs() {
    return Padding(
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
    );
  }

  Padding _appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Welcome Back!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
              const SizedBox(width: 24),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Icon(Icons.person_rounded, color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
