import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/screens/profile/profile_page.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/assets.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/home_tab/home_carousel.dart';
import 'package:icragee_mobile/widgets/home_tab/notification_card.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(
              top: 8,
              bottom: 10,
            ),
            child: const Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            ),
          ),
          const HomeCarousel(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                ),
                StreamBuilder(
                  stream: DataService.getNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ));
                    }
                    if (snapshot.hasError && !snapshot.hasData) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Something went wrong!'),
                      ));
                    }
                    final notifications = snapshot.data!;
                    if (notifications.isEmpty) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No notifications yet!'),
                      ));
                    }
                    return ListView.builder(
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final noti = notifications[index];
                        final timeAgo = timeago.format(DateTime.parse(noti.timestamp).toLocal(),
                            locale: 'en_short');
                        return NotificationCard(noti: noti, timeAgo: timeAgo);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: MyColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      title: Consumer(builder: (context, ref, child) {
        final user = ref.read(userProvider)!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              "Hello,",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: MyColors.whiteColor.withOpacity(0.8),
              ),
            ),
            Text(
              user.fullName,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: MyColors.whiteColor,
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
          icon: Image.asset(MyIcons.homeProfile, height: 36),
        ),
        const SizedBox(width: 4)
      ],
    );
  }
}
