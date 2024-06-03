import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/firebase_options.dart';
import 'package:icragee_mobile/routing/route_config.dart';
import 'package:icragee_mobile/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ICRAGEE',
      routerConfig: routeConfig,
    );
  }
}
