import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/firebase_options.dart';
import 'package:icragee_mobile/routing/route_config.dart';
import 'package:icragee_mobile/services/notification_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';

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
      scaffoldMessengerKey: scaffoldMessengerkey,
      debugShowCheckedModeBanner: false,
      title: 'ICRAGEE',
      routerConfig: routeConfig,
      theme: ThemeData(
        // Use Google Fonts for the entire app
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: MyColors.whiteColor,
          selectionColor: MyColors.primaryColor.withOpacity(0.4),
        ),
      ),
    );
  }
}
