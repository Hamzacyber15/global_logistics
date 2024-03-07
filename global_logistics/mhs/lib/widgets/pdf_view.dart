import 'package:flutter/material.dart';

class PdfView extends StatelessWidget {
  final String url;
  const PdfView({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height, child: Container()
        // SfPdfViewer.network(
        //   url,
        //   enableTextSelection: false,
        // ),
        );
  }
}
