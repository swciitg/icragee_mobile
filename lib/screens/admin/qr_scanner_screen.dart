import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  late MobileScannerController mobileScannerController;

  @override
  void initState() {
    mobileScannerController = MobileScannerController(
      autoStart: true,
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: MyColors.primaryColorTint,
      body: Center(
        child: Container(
          height: width * 0.8,
          width: width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: MyColors.primaryColor,
              width: 4,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: MobileScanner(
              controller: mobileScannerController,
              onDetect: (code) {
                final email = code.barcodes.first.displayValue ?? "";
                print(email);
                if (!_isEmail(email)) {
                  showSnackBar("Invalid QR Code");
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Scan QR Code',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
      ),
      backgroundColor: MyColors.primaryColor,
    );
  }

  bool _isEmail(String value) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(value);
  }
}
