import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/routing/app_routes.dart';
import 'package:icragee_mobile/screens/admin/admin_screen.dart';
import 'package:icragee_mobile/screens/get_started/get_started.dart';
import 'package:icragee_mobile/screens/home_screen.dart';
import 'package:icragee_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:icragee_mobile/screens/splash.dart';
import 'package:icragee_mobile/widgets/onboarding/login_screen.dart';
import '../screens/add_event_screen.dart';

final routeConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.splashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/admin-screen',
      builder: (context, state) => const AdminScreen(),
    ),
    GoRoute(
      path: '/homeScreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/addEventScreen',
      builder: (context, state) => const AddEventScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login-screen',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/get-started',
      builder: (context, state) => const GetStarted(),
    )
  ],
);
