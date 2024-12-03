import 'package:file_picker/file_picker.dart';

import '../../models/matiere.dart';

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
}
