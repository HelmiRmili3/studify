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

  // Convert FileItem to JSON
  Map<String, dynamic> toJson() => {
        'fileId': fileId,
        'fileName': fileName,
        'fileUrl': fileUrl,
        'uploadDate': uploadDate.toIso8601String(),
      };

  // Convert JSON to FileItem
  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      fileId: json['fileId'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
      uploadDate: DateTime.parse(json['uploadDate']),
    );
  }
}
