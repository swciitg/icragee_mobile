import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

class MainTitle extends StatelessWidget {
  final String eventTitle;
  final String speaker;
  final String time;
  final String date;

  const MainTitle({
    super.key,
    required this.eventTitle,
    required this.speaker,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures the container takes full width
      color: MyColors.primaryColor,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns children to the start
        children: [
          Text(
            eventTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            speaker,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          //const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  iconSize: 35,
                  onPressed: () {},
                  icon: Icon(Icons.location_on_outlined)),
            ],
          ),
        ],
      ),
    );
  }
}

class eventile extends StatelessWidget {
  final int totalEvents;
  const eventile({super.key, required this.totalEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: totalEvents,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 120,
          color: MyColors.primaryColor,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          /*child: Text(
            'Event ${index + 1}',
            style: const TextStyle(color: Colors.white),
          ),*/
        );
      },
    );
  }
}
