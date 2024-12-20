import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfView extends StatelessWidget {
  final File pdfFile;

  const PdfView({super.key, required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfFile.path,
        enableSwipe: true,
        // Allow horizontal swiping
        pageFling: true,
        // Enable page flinging
        pageSnap: false,
        // Disable page snapping
        fitEachPage: true,
      ),
    );
  }
}
