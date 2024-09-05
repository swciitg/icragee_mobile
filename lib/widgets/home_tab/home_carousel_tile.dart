import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:intl/intl.dart';

class HomeCarouselTile extends StatelessWidget {
  final Schedule event;

  const HomeCarouselTile({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 16,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: MyColors.navBarBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Speaker Name: Speaker",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            event.description,
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
                  DateFormat('k:mm').format(event.startTime),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 5),
                Text(
                  event.location,
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
