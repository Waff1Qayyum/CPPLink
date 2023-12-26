import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class AdminQuickFind extends StatefulWidget {
  const AdminQuickFind({super.key});

  @override
  State<AdminQuickFind> createState() => _AdminQuickFindState();
}

class _AdminQuickFindState extends State<AdminQuickFind> {
  TextEditingController _qrResult = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Quick Find',
          style: TextStyle(
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // You can replace this with your custom logo
            color: Colors.white, // Icon color
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/admin_home', (route) => false);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 400,
              child: Stack(
                children: [
                  MobileScanner(
                    // fit: BoxFit.contain,
                    controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.noDuplicates,
                      facing: CameraFacing.front,
                      torchEnabled: true,
                    ),
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      for (var barcode in barcodes) {
                        _qrResult.text = barcode.rawValue ?? '';
                      }
                    },
                  ),
                  QRScannerOverlay(
                    overlayColor: Colors.black,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('QR Results'),
                    border: OutlineInputBorder(),
                  ),
                  controller: _qrResult,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
