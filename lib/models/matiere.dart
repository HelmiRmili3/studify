// File.dart
class File {
  String filename;
  String filepath;

  File({required this.filename, required this.filepath});

  // Convert File to JSON
  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'filepath': filepath,
    };
  }

  // Convert JSON to File
  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      filename: json['filename'],
      filepath: json['filepath'],
    );
  }
}

// Doc.dart

class Doc {
  String id;
  String title;
  String message;
  List<File> files;

  Doc({
    required this.id,
    required this.title,
    required this.message,
    this.files = const [],
  });

  // Convert Doc to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'files': files.map((file) => file.toJson()).toList(),
    };
  }

  // Convert JSON to Doc
  factory Doc.fromJson(Map<String, dynamic> json) {
    return Doc(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      files: (json['files'] as List<dynamic>)
          .map((file) => File.fromJson(file))
          .toList(),
    );
  }
}

// Matiere.dart

class Matiere {
  String id;
  String name;
  String description;
  String professor;
  List<String> docIds; // List of document IDs
  List<Doc> docs; // List of Doc objects

  Matiere({
    required this.id,
    required this.name,
    required this.description,
    required this.professor,
    this.docIds = const [],
    this.docs = const [],
  });

  // Convert Matiere to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'professor': professor,
      'docIds': docIds,
      'docs': docs.map((doc) => doc.toJson()).toList(),
    };
  }

  // Convert JSON to Matiere
  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      professor: json['professor'],
      docIds: List<String>.from(json['docIds']),
      docs: (json['docs'] as List<dynamic>)
          .map((doc) => Doc.fromJson(doc))
          .toList(),
    );
  }
}
