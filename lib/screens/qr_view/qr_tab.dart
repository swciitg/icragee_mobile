import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/qr_code_widget.dart';

class QrTab extends ConsumerStatefulWidget {
  const QrTab({super.key});

  @override
  ConsumerState<QrTab> createState() => _QrTabState();
}

class _QrTabState extends ConsumerState<QrTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: MyColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        title: Text(
          "Food Coupon",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: MyColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: QrCodeWidget(),
            ),
            SizedBox(height: 20),
            Text(
              "Food Preference: ${ref.read(userProvider)?.foodPreference}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
