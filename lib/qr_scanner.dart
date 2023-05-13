import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcodescanner/result_screen.dart';


import 'qr_code_scanner_overley.dart';

const bgColor = Color(0xfffafaaa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanedCompleted = false;
  bool isForntCamera = false;
  bool isFlashOn = false;
  MobileScannerController mobileScannerController = MobileScannerController();

  void closedScreen() {
    isScanedCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });

              mobileScannerController.toggleTorch();
            },
            icon: Icon(Icons.flash_on),
            color: isFlashOn ? Colors.blue : Colors.grey,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isForntCamera = !isForntCamera;
              });

              mobileScannerController.switchCamera();
            },
            icon: Icon(Icons.camera_front),
            color: isForntCamera ? Colors.blue : Colors.grey,
          ),
        ],
        actionsIconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "QR Scanner",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black54,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Place the QR Code in the area",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning will be statred automatically",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black54,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  child: Stack(
                children: [
                  MobileScanner(
                    controller: mobileScannerController,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      final Uint8List? image = capture.image;

                      for (final barcode in barcodes) {
                        if (!isScanedCompleted) {
                          String code = barcode.rawValue ?? "---";
                          isScanedCompleted = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                        closeScreen: closedScreen,
                                        code: code,
                                      )));
                        }
                      }
                    },
                  ),
                  Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 5,
                  
                  
                ),
              ),
            ),
          ),
                ],
              ),),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Designed By Md. Rahul Reza",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                      letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
