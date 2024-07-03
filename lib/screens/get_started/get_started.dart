import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/screens/splash.dart';
class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  //BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    return const get_Started();
  }

}

class get_Started extends StatelessWidget {
  const get_Started({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/get_started_image.png',
              // Replace with your image path
              fit: BoxFit.cover, // Cover the entire screen with the image
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 560),
                const Text(
                  "Lorem ipsum dolor",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '''consectetur adipiscing elit, sed do  
             eiusmod tempor incididunt ut labore et dolore
                magna aliqua''',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.go('/homeScreen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C40),
                    // Background color
                    foregroundColor: Colors.white,
                    // Text color
                    minimumSize: const Size(310, 51),
                    // Width and height
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                ,

              ],
            )

          ],
        )

    );
  }
}