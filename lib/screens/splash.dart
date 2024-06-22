import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/screens/get_started/get_started.dart';
import 'package:icragee_mobile/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        backgroundColor: const Color(0xFF25D2B7),
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
            const LoginButton(buttonName:"Log in as Admin",routePath:'/get-started'),
            const SizedBox(height: 24),
            const LoginButton(buttonName:"Log in as Guest",routePath:'/get-started'),
          ],
        )

      );
  }

}

class LoginButton extends StatelessWidget {
  final String buttonName;
  final String routePath;
  const LoginButton({
    super.key,
    required this.buttonName,
    required this.routePath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        context.go(routePath);
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
      child: Text(
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
