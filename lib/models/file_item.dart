class FileItem {
  final String fileId; // Unique identifier for the file
  final String fileName; // Name of the file
  final String fileUrl; // URL or path to the file
  final DateTime uploadDate; // Date when the file was uploaded

  FileItem({
    required this.fileId,
    required this.fileName,
    required this.fileUrl,
    required this.uploadDate,
  });
  Map<String, dynamic> toJson() => {
        'fileId': fileId,
        'fileName': fileName,
        'fileUrl': fileUrl,
        'uploadDate': uploadDate.toIso8601String(),
      };
}
