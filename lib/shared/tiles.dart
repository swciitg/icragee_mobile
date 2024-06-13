import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

class MainTitle extends StatelessWidget {
  final String eventTitle;
  final String speaker;
  final String time;
  final String location;
  final String description;

  const MainTitle({
    super.key,
    required this.eventTitle,
    required this.speaker,
    required this.time,
    required this.location,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures the container takes full width
      decoration: BoxDecoration(
        color: MyColors.navBarBackgroundColor,
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns children to the start
        children: [
          Text(
            eventTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Speaker Name: " + speaker,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),

          //const SizedBox(height: 10),
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Icon(Icons.access_time_outlined),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  iconSize: 35,
                  onPressed: () {},
                  icon: Icon(Icons.location_on_outlined)),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  final int totalEvents;
  const EventTile({super.key, required this.totalEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: totalEvents,
      itemBuilder: (context, index) {
        return NotificationTiles(); // Return the NotificationTiles widget
      },
    );
  }
}
/*
class NotificationTiles extends StatelessWidget {
  const NotificationTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: MyColors.navBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Stack(
        children: [
          // Main content of the container
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Lorem ipsum dolor sit amet. Et repudiandae error est nihil odio et accusantium dolores. Eos voluptas iusto quo totam nostrum et quia laborum qui aliquam quas.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          // Positioned icon and text at the top right
          Positioned(
            right: 10,
            top: 10,
            child: Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  '9:00',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

class NotificationTiles extends StatefulWidget {
  const NotificationTiles({super.key});

  @override
  _NotificationTilesState createState() => _NotificationTilesState();
}

class _NotificationTilesState extends State<NotificationTiles> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        height: _isExpanded ? 140 : 90,
        decoration: BoxDecoration(
          color: MyColors.navBarBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Stack(
          children: [
            // Main content of the container
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Lorem ipsum dolor sit amet. Et repudiandae error est nihil odio et accusantium dolores. Eos voluptas iusto quo totam nostrum et quia laborum qui aliquam quas.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            // Positioned icon and text at the top right
            Positioned(
              right: 10,
              top: 10,
              child: Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '9:00',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
