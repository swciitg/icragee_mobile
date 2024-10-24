import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/services/api_service.dart';
import 'package:icragee_mobile/shared/assets.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _otpController;
  var otpSent = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
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
          _backButton()
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
            emailController: _emailController,
            label: 'Username',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          if (otpSent)
            CustomTextField(
              emailController: _otpController,
              label: 'Username',
              keyboardType: TextInputType.number,
            ),
          if (otpSent) const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // ApiService().sendOTP(_emailController.text.trim());
                while (context.canPop()) {
                  context.pop();
                }
                context.push('/homeScreen');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  !otpSent ? "Next" : "Send OTP",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
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
