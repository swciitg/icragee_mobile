import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/notification_tile.dart';
import 'package:intl/intl.dart';

class MainTitle extends StatelessWidget {
  final String eventTitle;
  final String speaker;
  final DateTime time;
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.navBarBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            "Speaker Name: $speaker",
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_outlined),
                const SizedBox(width: 5),
                Text(
                  DateFormat('k:mm').format(time),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 5),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
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

class EventTile extends StatelessWidget {
  final int totalEvents;

  const EventTile({super.key, required this.totalEvents});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          totalEvents,
          (index) => NotificationTile(
                title: 'Admin',
                body:
                    'Lorem ipsum dolor sit amet. Et repudiandae error est nihil odio et accusantium dolores. Eos voluptas iusto quo totam nostrum et quia laborum qui aliquam quas.',
                time: DateTime.now(),
              )),
    );
  }
}
