import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

String iamgeToString(File file) {
  final Uint8List _file = file.readAsBytesSync();
  return jsonEncode(_file);
}
