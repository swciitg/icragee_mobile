import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'finished':
        color = Colors.black;
        break;
      case 'ongoing':
        color = Colors.orange;
        break;
      case 'upcoming':
        color = MyColors.primaryColor;
        break;
      default:
        color = Colors.grey;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 2,
            ),
            // Black dot
            Container(
              width: 8, // Width of the dot
              height: 8, // Height of the dot
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4), // Space between the dot and text
            Text(
              status,
              style: TextStyle(color: color),
            ),
            const SizedBox(
              width: 2,
            )
          ],
        ),
      ),
    );
  }
}
