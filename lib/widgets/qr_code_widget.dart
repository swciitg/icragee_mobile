import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends ConsumerWidget {
  const QrCodeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.read(userProvider)!.id;
    final qr = QrImageView(
      data: id,
      version: QrVersions.auto,
      size: 300,
      gapless: true,
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
