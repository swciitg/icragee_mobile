import 'package:flutter/material.dart';
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
        title: const Text(
          'Scan the QR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: const Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: QrCodeWidget(data: 'Your QR Code Data'),
        ),
      ),
    );
  }
}
