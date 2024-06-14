import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/qr_code_widget.dart';
import 'package:intl/intl.dart';

class QrTab extends StatefulWidget {
  const QrTab({super.key});

  @override
  State<QrTab> createState() => _QrTabState();
}

class _QrTabState extends State<QrTab> {
  String _currentMeal = '';

  @override
  void initState() {
    super.initState();
    _updateMeal();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateMeal();
    });
  }

  void _updateMeal() {
    final now = DateTime.now();
    String meal;
    if (now.hour >= 5 && now.hour < 11) {
      meal = 'Breakfast';
    } else if (now.hour >= 11 && now.hour < 15) {
      meal = 'Lunch';
    } else if (now.hour >= 15 && now.hour < 21) {
      meal = 'Dinner';
    } else {
      meal = 'No Meal Time';
    }

    setState(() {
      _currentMeal = meal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Food Coupon',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 1),
            const Text(
              'Lorem ipsum dolor sit amet',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: QrCodeWidget(data: 'Your QR Code Data'),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _currentMeal,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  children: [
                    Icon(Icons.access_time, size: 15),
                    SizedBox(width: 5),
                    Text(
                      // '${now.hour}:${now.minute.toString().padLeft(2, '0')}'
                      "9:00 - 12:00",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_sharp, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
