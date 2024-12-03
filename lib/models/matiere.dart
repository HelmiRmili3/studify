// File.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/core/utils/enums.dart';

import '../core/utils/helpers.dart';

class FileEntity {
  String filename;
  String filepath;

  FileEntity({
    required this.filename,
    required this.filepath,
  });
  // Convert File to JSON
  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'filepath': filepath,
    };
  }

  // Convert JSON to File
  factory FileEntity.fromJson(Map<String, dynamic> json) {
    return FileEntity(
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
  List<FileEntity> files;

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
          .map((file) => FileEntity.fromJson(file))
          .toList(),
    );
  }
}

// Matiere.dart

class Matiere {
  String id;
  String name;
  String professor;
  List<double> raitings;
  List<int> favorites;
  String filiere;
  String description;
  MatierePart part;
  String coefficient;
  MatiereType type;
  FileEntity? coverPhoto;

  Matiere({
    required this.id,
    required this.name,
    required this.professor,
    this.raitings = const [],
    this.favorites = const [],
    required this.filiere,
    required this.description,
    required this.part,
    required this.coefficient,
    required this.type,
    required this.coverPhoto,
  });

  // Convert Matiere to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'professor': professor,
      'raitings': raitings,
      'favorites': favorites,
      'filiere': filiere,
      'description': description,
      'part': part.index,
      'coefficient': coefficient,
      'type': type.index,
      'coverPhoto': coverPhoto?.toJson(),
    };
  }

  // Convert JSON to Matiere
  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      id: json['id'],
      name: json['name'],
      professor: json['professor'],
      raitings: List<double>.from(json['raitings'] ?? []),
      favorites: List<int>.from(json['favorites'] ?? []),
      filiere: json['filiere'],
      description: json['description'],
      part: convertToEnumPart(json['part']),
      coefficient: json['coefficient'],
      type: convertToEnumType(json['type']),
      coverPhoto: FileEntity.fromJson(json['coverPhoto']),
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
    String? professor,
    List<double>? raitings,
    List<int>? favorites,
    String? filiere,
    String? description,
    MatierePart? part,
    String? coefficient,
    MatiereType? type,
    FileEntity? coverPhoto,
  }) {
    return Matiere(
      id: id ?? this.id,
      name: name ?? this.name,
      professor: professor ?? this.professor,
      raitings: raitings ?? this.raitings,
      favorites: favorites ?? this.favorites,
      filiere: filiere ?? this.filiere,
      description: description ?? this.description,
      part: part ?? this.part,
      coefficient: coefficient ?? this.coefficient,
      type: type ?? this.type,
      coverPhoto: coverPhoto ?? this.coverPhoto,
    );
  }
}
