import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:intl/intl.dart';

class NotificationTile extends StatefulWidget {
  final String title;
  final String body;
  final DateTime time;

  const NotificationTile(
      {required this.title, required this.body, required this.time, super.key});

  @override
  State createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String fullMessage = widget.body;
    String shortMessage = '${fullMessage.split(' ').take(15).join(' ')}...';

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: MyColors.navBarBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('k:mm').format(widget.time),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              _isExpanded ? fullMessage : shortMessage,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
