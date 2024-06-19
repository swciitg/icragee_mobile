import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/screens/get_started/get_started.dart';
import 'package:icragee_mobile/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF25D2B7),
        body:Column(
          children:<Widget>[
            const SizedBox(height: 230),
            //Image from widget
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 350,

              ),
            ),
            buildElevatedButton(context,"Log in as Admin"),

            const SizedBox(height: 24),
            buildElevatedButton(context,"Log in as Guest"),],
        )

      ),
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context, String buttonName) {
    return ElevatedButton(
            onPressed: () async {
               context.go('/get-started');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor:Colors.white ,
              //primary: Color(0xFFFF8C40), // Background color
              backgroundColor: Color(0xFFFF8C40), // Text color
              minimumSize: Size(310, 51), // Width and height
              padding: EdgeInsets.symmetric(vertical: 13), // Padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child:Text(
              buttonName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
}
