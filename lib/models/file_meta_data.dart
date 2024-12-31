class FileMetadata {
  final String name;
  final String url;
  final int size;
  final DateTime uploadTime;

  FileMetadata({
    required this.name,
    required this.url,
    required this.size,
    required this.uploadTime,
  });

  // Convert a FileMetadata instance to a Map for Firestore or JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'size': size,
      'uploadTime': uploadTime.toIso8601String(),
    };
  }

  // Create a FileMetadata instance from a Map (e.g., from Firestore or JSON)
  factory FileMetadata.fromJson(Map<String, dynamic> json) {
    return FileMetadata(
      name: json['name'] as String,
      url: json['url'] as String,
      size: json['size'] as int,
      uploadTime: DateTime.parse(json['uploadTime'] as String),
    );
  }

  @override
  String toString() {
    return 'FileMetadata(name: $name, url: $url, size: $size, uploadTime: $uploadTime)';
  }
}
