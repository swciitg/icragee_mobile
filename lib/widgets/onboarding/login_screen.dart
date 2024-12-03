import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/api_service.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/assets.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/custom_text_field.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _otpController;
  var otpSent = false;
  var loading = false;
  var admin = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _otpController = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      admin = ref.read(userProvider.notifier).adminAuth;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _sendOTP() async {
    if (!_verify()) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await ApiService.sendOTP(_emailController.text.trim(), admin: admin);
      showSnackBar("OTP sent successfully to: ${_emailController.text.trim()}");
      setState(() {
        otpSent = true;
      });
    } catch (e) {
      showSnackBar("Sending OTP failed, Please try again");
    }
    setState(() {
      loading = false;
    });
  }

  void _verifyOTP(WidgetRef ref) async {
    if (!_verify()) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      final val = await ApiService.verifyOTP(
          _emailController.text.trim(), _otpController.text.trim(),
          admin: admin);
      if (!val) {
        showSnackBar("Invalid OTP, Please try again");
        setState(() {
          loading = false;
        });
        return;
      }
      final userDetails = await UserDetails.getFromSharedPreferences();
      await DataService.updateUserDetails(userDetails!, containsFirestoreData: false);
      ref.read(userProvider.notifier).setUserDetails(userDetails);
      ref.read(userProvider.notifier).updateIfSuperUser();
      while (navigatorKey.currentContext!.canPop()) {
        navigatorKey.currentContext!.pop();
      }
      try {
        FirebaseMessaging.instance.subscribeToTopic('All');
      } catch (e) {
        Logger().e(e);
      }
      for (int i = 0; i < userDetails.eventList.length; i++) {
        try {
          await FirebaseMessaging.instance.subscribeToTopic(userDetails.eventList[i]);
        } catch (e) {
          Logger().e(e);
        }
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('admin', admin);
      navigatorKey.currentContext!.pushReplacement(admin ? '/admin-screen' : '/homeScreen');
      return;
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar("Something went wrong, Please try again");
    }
    setState(() {
      loading = false;
    });
  }

  bool _verify() {
    if (_emailController.text.trim().isEmpty) {
      showSnackBar("Email cannot be empty");
      return false;
    }
    if (otpSent && _otpController.text.trim().isEmpty) {
      showSnackBar("OTP cannot be empty");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              MyImages.getStartedImage,
            ),
          ),
          Positioned(
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
          ),
          _form(),
          _backButton(),
          if (loading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: MyColors.primaryColor),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Positioned _form() {
    return Positioned(
      bottom: 16,
      right: 16,
      left: 16,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          if (otpSent)
            CustomTextField(
              controller: _otpController,
              label: 'OTP',
              keyboardType: TextInputType.number,
            ),
          if (otpSent) const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Consumer(builder: (context, ref, child) {
              return GestureDetector(
                onTap: otpSent ? () => _verifyOTP(ref) : () => _sendOTP(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    otpSent ? "Next" : "Send OTP",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Positioned _backButton() {
    return Positioned(
      top: kToolbarHeight,
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: MyColors.whiteColor,
        ),
      ),
    );
  }
}
