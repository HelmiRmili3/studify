import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:studify/core/utils/firestore.dart';
import 'package:studify/models/matiere.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/firestore_filter_model.dart';
import '../../../../../models/file_item.dart';

class MatiereRepository {
  Stream<List<Doc>> fetchDocsByFilters(List<FirestoreFilter> filters) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(Firestore.docs);
    Query query = collectionRef;

    for (var filter in filters) {
      switch (filter.operation) {
        case '==':
          query = query.where(filter.field, isEqualTo: filter.value);
          break;
        case '<':
          query = query.where(filter.field, isLessThan: filter.value);
          break;
        case '<=':
          query = query.where(filter.field, isLessThanOrEqualTo: filter.value);
          break;
        case '>':
          query = query.where(filter.field, isGreaterThan: filter.value);
          break;
        case '>=':
          query =
              query.where(filter.field, isGreaterThanOrEqualTo: filter.value);
          break;
        case 'array-contains':
          query = query.where(filter.field, arrayContains: filter.value);
          break;
        case 'array-contains-any':
          query = query.where(filter.field, arrayContainsAny: filter.value);
          break;
        case 'in':
          query = query.where(filter.field, whereIn: filter.value);
          break;
        default:
          throw ArgumentError(
              'Unsupported filter operation: ${filter.operation}');
      }
    }

    return query.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Doc.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addDoc(
    Doc doc,
    List<PlatformFile> files,
  ) async {
    try {
      List<FileItem> fileItems = [];

      for (var file in files) {
        final filePath = file.path;
        final fileName = file.name;

        if (filePath == null) {
          throw Exception('File path is null for file: $fileName');
        }

        final storageRef =
            FirebaseStorage.instance.ref('${Firestore.docs}/').child(fileName);
        await storageRef.putFile(File(filePath));

        await storageRef.getDownloadURL().then((downloadUrl) {
          debugPrint('Download URL: $downloadUrl');
          fileItems.add(
            FileItem(
              fileId: const Uuid().v1(),
              fileName: fileName,
              fileUrl: downloadUrl,
              uploadDate: DateTime.now(),
            ),
          );
        });
      }

      await FirebaseFirestore.instance
          .collection(Firestore.docs)
          .doc(doc.id)
          .set(doc.copyWith(files: fileItems).toJson());
    } catch (e) {
      throw Exception('Failed to add doc: $e');
    }
  }
}
