import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/qr_code_widget.dart';

class QrTab extends StatefulWidget {
  const QrTab({super.key});

  @override
  State<QrTab> createState() => _QrTabState();
}

class _QrTabState extends State<QrTab> {
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
      body: const Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: QrCodeWidget(),
        ),
      ),
    );
  }
}
