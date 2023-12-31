import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

import '../controller.dart';

class AdminQuickFind extends StatefulWidget {
  const AdminQuickFind({super.key});

  @override
  State<AdminQuickFind> createState() => _AdminQuickFindState();
}

class _AdminQuickFindState extends State<AdminQuickFind> {
  bool isLoading = false;
  TextEditingController _qrResult = TextEditingController();

  checkParcelAndredirect(String parcel_id) async {
    await findParcel(parcel_id);
    if (tracking_id != "" &&
        customerName != "" &&
        customerNumber != "" &&
        dateArrived != "" &&
        status != "" &&
        shelf_number != "") {
      print("parcel id is not found");
      Navigator.of(context).pushReplacementNamed('/admin_quickFindResult');
    } else {
      print("parcel id is not found");
    }
  }

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
      body: Stack(
        children: [
          ListView(
            children: [
              Center(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Scan Parcel Qr code to easily get the parcel detail.',
                        style: TextStyle(
                          color: Color(0xFF050505),
                          fontSize: 17,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                          height: 0.00,
                        )),
                    SizedBox(height: 20),
                    Container(
                      width: 310,
                      height: 310,
                      child: Stack(
                        children: [
                          MobileScanner(
                            fit: BoxFit.cover,
                            controller: MobileScannerController(
                              detectionSpeed: DetectionSpeed.noDuplicates,
                              facing: CameraFacing.back,
                              torchEnabled: false,
                            ),
                            onDetect: (capture) {
                              final List<Barcode> barcodes = capture.barcodes;
                              for (var barcode in barcodes) {
                                _qrResult.text = barcode.rawValue ?? '';
                              }
                            },
                          ),
                          QRScannerOverlay(
                            scanAreaSize:
                                Size(340, 340), // Adjust the size as needed
                            overlayColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Parcel Track number',
                        style: TextStyle(
                          color: Color(0xFF050505),
                          fontSize: 17,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                          height: 0.00,
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    // ),

                    Center(
                      child: SizedBox(
                        width: 230,
                        child: TextFormField(
                          // readOnly: true,
                          autofocus: true,
                          decoration: InputDecoration(
                            label: Text('QR Results'),
                            border: OutlineInputBorder(
// ({Color color = const Color(0xFF000000), double width = 1.0, BorderStyle style = BorderStyle.solid, double strokeAlign = strokeAlignInside})
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                          ),
                          controller: _qrResult,
                          onChanged: (value) async {
                            isLoading = true;
                            setState(() {});
                            checkParcelAndredirect(value);
                            await findParcel(value);
                            isLoading = false;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
          // Loading indicator overlay
          if (isLoading)
            Container(
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.asset('assets/yellow_loading.json'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
