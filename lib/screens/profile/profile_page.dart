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
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

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
          _buildUserDetails(),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
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

  Container _buildUserDetails() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailTile("Institute", "Indian Institute of Technology, Guwahati"),
          _buildDetailTile("Email ID", user.email),
          _buildDetailTile("Registratin Category", user.registrationCategory, isLast: true),
        ],
      ),
    );
  }

  Widget _buildDetailTile(String title, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff1C1C1C),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColors.primaryColorTint,
                      width: 4,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyColors.whiteColor,
                  ),
                ),
                Text(
                  user.email.split('@').first,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                navigatorKey.currentContext!.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: MyColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
