import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/screens/admin/meal_details_screen.dart';
import 'package:icragee_mobile/screens/feedback/feedback_page.dart';
import 'package:icragee_mobile/screens/map_entries/map_sections_page.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/screens/profile/lost_and_found_screen.dart';
import 'package:icragee_mobile/screens/schedule/event_venue_screen.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/profile_screen/profile_details_card.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final bool admin;
  const ProfilePage({super.key, this.admin = false});

  @override
  ConsumerState<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  late UserDetails user;

  @override
  void initState() {
    user = ref.read(userProvider)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 24),
          ProfileDetailsCard(user: user, admin: widget.admin),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Day wise schedule'),
                  onTap: () async {
                    final url = await DataService.getScheduleUrl();
                    if (url != null) {
                      launchUrlString(url);
                    } else {
                      showSnackBar('Schedule not available');
                    }
                  },
                ),
                Container(height: 1, color: MyColors.primaryColor),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Important contacts'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ImportantContacts()));
                  },
                ),
                Container(height: 1, color: MyColors.primaryColor),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Feedback'),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const FeedbackPage()));
                  },
                ),
                Container(height: 1, color: MyColors.primaryColor),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Lost/Found items'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LostAndFoundScreen(),
                      ),
                    );
                  },
                ),
                Container(height: 1, color: MyColors.primaryColor),
                Consumer(builder: (context, ref, child) {
                  final role = ref.read(userProvider)!.role;
                  if (role != AdminRole.superAdmin && role != AdminRole.eventsVolunteer) {
                    return const SizedBox();
                  }
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Map Entries'),
                        onTap: () async {
                          navigatorKey.currentState!
                              .push(MaterialPageRoute(builder: (_) => MapSectionsPage()));
                        },
                      ),
                      Container(height: 1, color: MyColors.primaryColor),
                    ],
                  );
                }),
                Consumer(builder: (context, ref, child) {
                  final role = ref.read(userProvider)!.role;
                  if (role != AdminRole.superAdmin && role != AdminRole.eventsVolunteer) {
                    return const SizedBox();
                  }
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Event venues'),
                        onTap: () async {
                          navigatorKey.currentState!
                              .push(MaterialPageRoute(builder: (_) => EventVenueScreen()));
                        },
                      ),
                      Container(height: 1, color: MyColors.primaryColor),
                    ],
                  );
                }),
                Consumer(builder: (context, ref, child) {
                  final role = ref.read(userProvider)!.role;
                  if (role != AdminRole.superAdmin && role != AdminRole.foodVolunteer) {
                    return const SizedBox();
                  }
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Meal Taken Details'),
                        onTap: () async {
                          navigatorKey.currentState!.push(
                            MaterialPageRoute(
                              builder: (_) => MealDetailsScreen(),
                            ),
                          );
                        },
                      ),
                      Container(height: 1, color: MyColors.primaryColor),
                    ],
                  );
                }),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sign Out'),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text('Sign Out'),
                          content: Text('Are you sure you want to sign out?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                navigatorKey.currentState!.pop();
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final prefs = await SharedPreferences.getInstance();
                                prefs.clear();
                                while (navigatorKey.currentContext!.canPop()) {
                                  navigatorKey.currentContext!.pop();
                                }
                                navigatorKey.currentContext!.push("/get-started");
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAppBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(8).copyWith(
        top: kToolbarHeight,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    navigatorKey.currentContext!.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: MyColors.whiteColor,
                  ),
                ),
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
