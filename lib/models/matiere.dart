// File.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/models/file_item.dart';

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
  String creator;
  String matiereId;
  String title;
  String message;
  List<FileItem> files;
  DateTime date;

  Doc({
    required this.id,
    required this.title,
    required this.message,
    required this.creator,
    required this.matiereId,
    required this.date,
    this.files = const [],
  });

  // Convert Doc to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator,
      'matiereId': matiereId,
      'title': title,
      'message': message,
      'files': files.map((file) => file.toJson()).toList(),
      'date': date.toIso8601String(),
    };
  }

  // Convert JSON to Doc
  factory Doc.fromJson(Map<String, dynamic> json) {
    return Doc(
      id: json['id'],
      creator: json['creator'],
      matiereId: json['matiereId'],
      title: json['title'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      files: (json['files'] as List<dynamic>)
          .map((file) => FileItem.fromJson(file))
          .toList(),
    );
  }

  // Create a new Doc object by copying the current one with optional changes
  Doc copyWith({
    String? id,
    String? creator,
    String? matiereId,
    String? title,
    String? message,
    List<FileItem>? files,
    DateTime? date,
  }) {
    return Doc(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      matiereId: matiereId ?? this.matiereId,
      title: title ?? this.title,
      message: message ?? this.message,
      files: files ?? this.files,
      date: date ?? this.date,
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
