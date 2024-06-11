import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/tiles.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            iconSize: 42.0,
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              " Upcoming Events",
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            MainTitle(
              eventTitle: "Event Title",
              speaker: "Speaker",
              time: "Timing",
              date: "Date",
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Day 1",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Day 2",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Day 3",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(child: eventile(totalEvents: 5)),
          ],
        ),
      ),
    );
  }
}
