import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  final String url;
  const PdfView({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SfPdfViewer.network(
        url,
        enableTextSelection: false,
      ),
    );
  }
}
