import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/screens/home/home_tab.dart';
import 'package:icragee_mobile/screens/map_view/map_tab.dart';
import 'package:icragee_mobile/screens/qr_view/qr_tab.dart';
import 'package:icragee_mobile/screens/schedule/schedule_tab.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/tabs.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final pageController = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).updateUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        extendBody: true,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
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
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: const BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(HomeTabs.values.length, (index) {
          final tab = HomeTabs.values[index];
          return InkWell(
            onTap: () => setState(() {
              if ((index - selectedIndex).abs() != 1) {
                pageController.jumpToPage(index);
              } else {
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
              }
              selectedIndex = index;
            }),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                index == selectedIndex ? tab.selectedIconPath : tab.unselectedIconPath,
                height: 28,
              ),
            ),
          );
        }),
      ),
    );
  }
}
