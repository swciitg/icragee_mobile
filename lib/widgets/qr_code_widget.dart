import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends ConsumerWidget {
  final String data;
  const QrCodeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(userProvider)!.email;
    final qr = QrImageView(
      data: email,
      version: QrVersions.auto,
      size: 300,
      gapless: false,
      backgroundColor: Colors.white,
      embeddedImageStyle: const QrEmbeddedImageStyle(
        color: Colors.black,
      ),
      eyeStyle: const QrEyeStyle(
        color: Colors.black,
        eyeShape: QrEyeShape.square,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        color: Colors.black,
        dataModuleShape: QrDataModuleShape.square,
      ),
    );
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: qr,
      ),
    );
  }
}
