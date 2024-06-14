import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/home/home_tab.dart';
import 'package:icragee_mobile/screens/map_view/map_tab.dart';
import 'package:icragee_mobile/screens/qr_view/qr_tab.dart';
import 'package:icragee_mobile/screens/schedule/schedule_tab.dart';
import 'package:icragee_mobile/shared/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [
          HomeTab(),
          ScheduleTab(),
          MapTab(),
          QrTab(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.pink.shade50,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 60,
          elevation: 4,
          shadowColor: Colors.black,
          surfaceTintColor: MyColors.navBarBackgroundColor,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: MyColors.secondaryColor);
            } else {
              return const IconThemeData(color: Colors.grey);
            }
          }),
        ),
        child: NavigationBar(
            backgroundColor: MyColors.navBarBackgroundColor,
            selectedIndex: selectedIndex,
            onDestinationSelected: (i) => setState(() {
                  if ((i - selectedIndex).abs() != 1) {
                    pageController.jumpToPage(i);
                  } else {
                    pageController.animateToPage(i,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeIn);
                  }
                  selectedIndex = i;
                }),
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  FluentIcons.home_48_filled,
                  size: 28,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.calendar_48_filled,
                  size: 28,
                ),
                label: 'Schedule',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.location_48_filled,
                  size: 28,
                ),
                label: 'Map',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.food_48_filled,
                  size: 28,
                ),
                label: 'Food',
              ),
            ]),
      ),
    );
  }
}
