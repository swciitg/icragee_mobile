import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/shared/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(
        () {
          setState(() {});
          if (controller.status == AnimationStatus.completed) {
            final goRouter = context.go;
            goRouter('/get-started');
          }
        },
      );
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF25D2B7),
      body: Column(
        children: [
          const SizedBox(height: 230),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 350,
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              value: controller.value,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(
                MyColors.secondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
