import 'package:flutter/material.dart';
import 'package:icragee_mobile/widgets/notification_tile.dart';

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