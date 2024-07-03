import 'package:flutter/material.dart';

import 'package:icragee_mobile/models/schedule.dart';
import 'package:icragee_mobile/shared/colors.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(this.schedule, {super.key});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyColors.navBarBackgroundColor,
      ),
      margin: const EdgeInsets.all(3),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(schedule.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )),
                const Spacer(),
                const Icon(
                  Icons.place_outlined,
                  size: 25,
                )
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Row(children: [
                  const Icon(
                    Icons.access_time,
                    size: 15,
                  ),
                  Text(
                    ' ${schedule.timeStart.toStringAsFixed(2)} - ${schedule.timeEnd.toStringAsFixed(2)}  ',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const Icon(Icons.place_outlined, size: 15),
                  const Text(
                    ' Location',
                    style: TextStyle(fontSize: 10),
                  )
                ]),
                const Spacer(),
                SizedBox(
                  width: 120,
                  height: 20,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange,
                      side: const BorderSide(color: Colors.orange),
                    ),
                    icon: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    label: const Text('Ongoing'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}
