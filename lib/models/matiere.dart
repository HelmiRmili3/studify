// File.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/core/utils/enums.dart';

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
  String filiere;
  String description;
  int part;
  String coefficient;
  MatiereType type;

  Matiere({
    required this.id,
    required this.name,
    required this.filiere,
    required this.description,
    required this.part,
    required this.coefficient,
    required this.type,
  });

  // Convert Matiere to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'filiere': filiere,
      'description': description,
      'part': part,
      'coefficient': coefficient,
      'type': type.toString().split('.').last, // Save enum as string
    };
  }

  // Convert JSON to Matiere
  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      id: json['id'],
      name: json['name'],
      filiere: json['filiere'],
      description: json['description'],
      part: json['part'],
      coefficient: json['coefficient'],
      type: MatiereType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => MatiereType.Cours, // Default value
      ),
    );
  }

  // Create Matiere from Firestore DocumentSnapshot
  factory Matiere.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Matiere.fromJson({...data, 'id': doc.id});
  }

  // CopyWith method for creating modified copies
  Matiere copyWith({
    String? id,
    String? name,
    String? filiere,
    String? description,
    int? part,
    String? coefficient,
    MatiereType? type,
  }) {
    return Matiere(
      id: id ?? this.id,
      name: name ?? this.name,
      filiere: filiere ?? this.filiere,
      description: description ?? this.description,
      part: part ?? this.part,
      coefficient: coefficient ?? this.coefficient,
      type: type ?? this.type,
    );
  }
}
