import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'qr_code_widget.dart';




class QrTab extends StatelessWidget {
  const QrTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFC6FCED),
        appBar: AppBar(
          title: Text(
            'Food Coupon',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFFC6FCED),
        ),
        body: FoodCouponBody(),
      ),
    );
  }
}

class FoodCouponBody extends StatefulWidget {
  @override
  _FoodCouponBodyState createState() => _FoodCouponBodyState();
}

class _FoodCouponBodyState extends State<FoodCouponBody> {
  String _currentMeal = '';

  @override
  void initState() {
    super.initState();
    _updateMeal();
    Timer.periodic(Duration(minutes: 1), (timer) {
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 1),
          Text(
            'Lorem ipsum dolor sit amet',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              width: 300,
              height: 300,
              child: QrCodeWidget(data: 'Your QR Code Data'),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _currentMeal,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time,size:15),
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
                  Icon(Icons.calendar_today_sharp,size:15),
                  SizedBox(width: 5),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



