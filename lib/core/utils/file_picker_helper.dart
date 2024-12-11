import 'package:file_picker/file_picker.dart';

import '../../models/matiere.dart';
import 'collections.dart';

class FilePickerHelper {
  static Future<FileEntity?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      return FileEntity(
        filepath: result.files.single.path!,
        filename: result.files.single.name,
      );
    }
    return null;
  }

  static Future<FileEntity?> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.single.path != null) {
      return FileEntity(
        filepath: result.files.single.path!,
        filename: result.files.single.name,
      );
    }
    return null;
  }

  static Future<FileEntity?> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      return FileEntity(
        filepath: result.files.single.path!,
        filename: result.files.single.name,
      );
    }
    return null;
  }

  static Future<FilePickerResult?> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: Collections.all,
    );
    return result;
  }
}
