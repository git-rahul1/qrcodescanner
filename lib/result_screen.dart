import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qr_scanner.dart';

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const ResultScreen(
      {super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              closeScreen();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black45,
            )),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //qr code show here
            QrImage(
              data: code,
              version: QrVersions.auto,
              size: 150,
            ),

            Text(
              "Scanned Result",
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
              
              " ${code}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                },
                child: Text(
                  " Copy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                      letterSpacing: 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
