import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({Key? key, required this.status}) : super(key: key);

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
    return Chip(
      side: BorderSide.none,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      ),
      //backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}
