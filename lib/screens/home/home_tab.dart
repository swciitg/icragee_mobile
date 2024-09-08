import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/screens/profile/profile_page.dart';
import 'package:icragee_mobile/shared/assets.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/tiles.dart';
import 'package:icragee_mobile/widgets/home_tab/home_carousel.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: MyColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        title: Column(
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
              "Sumeet Ahire",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: MyColors.whiteColor,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: Image.asset(MyIcons.homeProfile, height: 36),
          ),
          const SizedBox(width: 4)
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    "Upcoming Events",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            HomeCarousel(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    "Notifications",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                  ),
                  EventTile(totalEvents: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
