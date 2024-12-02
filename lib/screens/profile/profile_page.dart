import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/screens/feedback/feedback_page.dart';
import 'package:icragee_mobile/screens/profile/faq_screen.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/screens/profile/lost_and_found_screen.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/profile_screen/profile_details_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          ProfileDetailsCard(user: user,admin: widget.admin),
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
                  title: const Text('FAQs'),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const FaqScreen()));
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
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sign Out'),
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    while (navigatorKey.currentContext!.canPop()) {
                      navigatorKey.currentContext!.pop();
                    }
                    navigatorKey.currentContext!.push("/get-started");
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
