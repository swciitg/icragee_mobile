import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/routing/app_routes.dart';
import 'package:icragee_mobile/screens/home_screen.dart';
import 'package:icragee_mobile/screens/splash.dart';

import '../screens/get_started/get_started.dart';

final routeConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.splashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/get-started',
      builder: (context, state) => const GetStarted(),
    ),
    GoRoute(
      path: '/homeScreen',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);

