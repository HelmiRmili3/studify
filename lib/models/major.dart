// import 'part.dart';

// class Major {
//   final String majorId; // Unique ID for the major (e.g., "CS101")
//   final String majorName; // Name of the major (e.g., "Computer Science")
//   final Part part1; // First part of the major
//   final Part part2; // Second part of the major

//   Major({
//     required this.majorId,
//     required this.majorName,
//     required this.part1,
//     required this.part2,
//   });

//   // Convert to Map for Firebase
//   Map<String, dynamic> toMap() {
//     return {
//       'majorId': majorId,
//       'majorName': majorName,
//       'part1': part1.toMap(),
//       'part2': part2.toMap(),
//     };
//   }

//   // Factory method to create Major from Firebase data
//   factory Major.fromMap(Map<String, dynamic> map) {
//     return Major(
//       majorId: map['majorId'],
//       majorName: map['majorName'],
//       part1: Part.fromMap(map['part1']),
//       part2: Part.fromMap(map['part2']),
//     );
//   }
// }
