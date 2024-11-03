import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/shared/assets.dart';
import 'package:icragee_mobile/shared/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  var _currentPage = 0;
  final _images = [
    MyImages.onboarding1,
    MyImages.onboarding2,
    MyImages.onboarding3,
    MyImages.onboarding4,
  ];
  final _titles = [
    "Stay in the Loop ",
    "Track Every Moment",
    "Track Every Moment",
    "Track Every Moment",
  ];

  final _subTitles = [
    "Get real-time updates on sessions, speakers, and important announcements. Never miss a moment.",
    "Stay organized with real-time event tracking. Keep your schedule at a glance and never miss a session or networking opportunity!",
    "Navigate the conference with ease! Use the map  to locate venues quickly, be at a right place at the right time.",
    'Welcome to IIT Guwahati,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: PageView.builder(
              itemCount: _images.length,
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned(
                      top: 100,
                      left: 32,
                      right: 32,
                      child: Image.asset(
                        _images[index],
                      ),
                    ),
                    _gradient(size),
                    _pageInfo(size, index),
                  ],
                );
              },
            ),
          ),
          _nextButton(),
          _backButton()
        ],
      ),
    );
  }

  Positioned _gradient(Size size) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: size.height * 0.6,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.primaryColor,
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.3, 1],
          ),
        ),
      ),
    );
  }

  Positioned _pageInfo(Size size, int index) {
    return Positioned(
      bottom: 60,
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _titles[index],
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _subTitles[index],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _nextButton() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: List.generate(
              4,
              (index) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? MyColors.secondaryColor
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_currentPage == 3) {
                context.push('/login-screen');
                return;
              }
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Next",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Positioned _backButton() {
    return Positioned(
      top: kToolbarHeight,
      child: IconButton(
        onPressed: () {
          if (_currentPage == 0) context.pop();
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
