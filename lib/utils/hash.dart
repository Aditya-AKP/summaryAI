import 'dart:convert';
import 'package:crypto/crypto.dart';


class Hash {
  static String generateHash(String text) {
    final normalized = text
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');

    final bytes = utf8.encode(normalized);
    return sha256.convert(bytes).toString();
  }
}