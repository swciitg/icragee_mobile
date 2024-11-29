import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/routing/app_routes.dart';
import 'package:icragee_mobile/screens/admin/add_notification_screen.dart';
import 'package:icragee_mobile/screens/admin/admin_screen.dart';
import 'package:icragee_mobile/screens/admin/qr_scanner_screen.dart';
import 'package:icragee_mobile/screens/get_started/get_started.dart';
import 'package:icragee_mobile/screens/home_screen.dart';
import 'package:icragee_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:icragee_mobile/screens/splash.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/onboarding/login_screen.dart';

import '../screens/add_event_screen.dart';

final routeConfig = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/',
      name: AppRoutes.splashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/admin-screen',
      builder: (context, state) => const AdminScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/homeScreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/addEventScreen',
      builder: (context, state) => const AddEventScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/addNotificationScreen',
      builder: (context, state) => const AddNotificationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/login-screen',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/get-started',
      builder: (context, state) => const GetStarted(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/qr-scanner',
      builder: (context, state) => const QrScannerScreen(),
    )
  ],
);
