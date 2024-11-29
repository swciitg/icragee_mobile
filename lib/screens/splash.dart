import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;

  void initDependencies() {}

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    DataService.fetchDayOneDate();
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(
        () async {
          setState(() {});
          if (controller.status == AnimationStatus.completed) {
            final goRouter = context.replace;
            final user = await UserDetails.getFromSharedPreferences();
            if (user == null) {
              goRouter('/get-started');
            } else {
              ref.read(userProvider.notifier).setUserDetails(user);
              final prefs = await SharedPreferences.getInstance();
              final admin = prefs.getBool('admin') ?? false;
              if (admin) {
                goRouter('/admin-screen');
              } else {
                goRouter('/homeScreen');
              }
            }
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
