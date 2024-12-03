import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/admin/access_update_screen.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  late MobileScannerController mobileScannerController;
  var scanned = false;

  @override
  void initState() {
    mobileScannerController = MobileScannerController(
      autoStart: true,
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
    super.initState();
  }

  @override
  void dispose() {
    mobileScannerController.stop();
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: MyColors.primaryColorTint,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                  onDetect: (code) async {
                    mobileScannerController.stop();
                    setState(() {
                      scanned = true;
                    });
                    final id = code.barcodes.first.displayValue ?? "";
                    debugPrint("ID: $id");
                    final user = await DataService.getUserDetailsById(id);
                    if (user == null) {
                      showSnackBar("No user found with ID: $id");
                      setState(() {
                        scanned = true;
                      });
                      return;
                    }
                    await navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => AccessUpdateScreen(user: user),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (scanned)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      scanned = false;
                    });
                    mobileScannerController.start();
                  },
                  child: Text("Scan again"),
                ),
              ),
          ],
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }
}
