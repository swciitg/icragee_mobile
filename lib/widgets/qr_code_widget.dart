import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String data;

  const QrCodeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Choose your border color here
            width: 2.0, // Choose the border width here
          ),
        ),
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 300.0,
          gapless: true,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
