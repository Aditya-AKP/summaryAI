import 'dart:typed_data';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  Future<String> extractText(Uint8List bytes) async {
    final document = PdfDocument(
      inputBytes: bytes,
    );

    try {
      final extractor = PdfTextExtractor(document);

      final text = extractor.extractText();

      return text.trim();
    } finally {
      document.dispose();
    }
  }
}