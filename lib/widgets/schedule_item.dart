import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icragee_mobile/models/schedule.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(this.schedule, {super.key});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
               children: [
                Text(schedule.title,  style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                )),
                const Spacer(),
               const Icon(Icons.place ,size: 30,)
               ],
            ),
           
            const SizedBox(height: 4),
            Text(schedule.description),
            Row(
              children: [
                Row(children: [
                  const Icon(Icons.access_time ,size: 20,),
                  Text(
                    ' ${schedule.timeStart.toStringAsFixed(2)} - ${schedule.timeEnd.toStringAsFixed(2)}  ',
                  ),
                  const Icon(Icons.place,size:20),
                  const Text(' Location')
                ]),
                const Spacer(),
                //    OutlinedButton.icon(
                //   onPressed: (){},
                //   style: OutlinedButton.styleFrom(
                //     foregroundColor: Colors.white,
                //   ),
                //   icon: const Icon(Icons.circle),
                //   label: const Text('Start Quiz'),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
