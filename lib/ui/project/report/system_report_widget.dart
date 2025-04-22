import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class SystemReportWidget extends StatelessWidget {
  final Uint8List? bytes;

  const SystemReportWidget({super.key, required this.bytes});

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfController(
      document: PdfDocument.openData(bytes!),
    );
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: PdfView(
            controller: pdfController,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.close,
            color: Colors.grey,
            size: 30.0,
          ),
        ),
      ]),
    );
  }
}
