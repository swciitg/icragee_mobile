import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/tiles.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Text(
              "Hello,",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Sumeet Ahire",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          /*IconButton(
            iconSize: 42.0,
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),*/
          IconButton(
            iconSize: 42.0,
            onPressed: () {
              // Navigator.push(
              // context, MaterialPageRoute(builder: (context) {ProfilePage()}));
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              " Upcoming Events",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            MainTitle(
              eventTitle: "Title Lorem Ipsum",
              speaker: "Speaker",
              time: "Timing",
              location: "Location",
              description:
                  "Lorem ipsum dolor sit amet. Et repudiandae error est nihil odio et accusantium dolores. Eos voluptas iusto quo totam nostrum et quia laborum qui aliquam quas.",
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              " Notifications",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            ),
            Expanded(child: EventTile(totalEvents: 5)),
          ],
        ),
      ),
    );
  }
}
