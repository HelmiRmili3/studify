import 'package:studify/core/common/storage.dart';

class Collections {
  static List<String> get image => [
        Storage.jpg,
        Storage.png,
        Storage.jpeg,
      ];
  static List<String> get video => [
        Storage.mp4,
      ];
  static List<String> get audio => [
        Storage.mp3,
      ];
  static List<String> get document => [
        Storage.pdf,
        Storage.docx,
        Storage.doc,
        Storage.txt,
        Storage.zip,
        Storage.rar,
        Storage.xlsx,
        Storage.csv,
      ];
  static List<String> get code => [
        Storage.py,
        Storage.java,
        Storage.js,
        Storage.html,
        Storage.css,
        Storage.json,
        Storage.xml,
      ];
  static List<String> get app => [
        Storage.apk,
        Storage.exe,
      ];
}
