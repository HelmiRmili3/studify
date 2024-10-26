import 'course.dart';

class Part {
  final String partId; // Unique ID for the part (e.g., "CS101_Part1")
  final String majorId; // ID of the associated major
  final String yearOfStudy; // Year of study (e.g., "Freshman", "Sophomore")
  final List<Course> courses; // List of courses in this part

  Part({
    required this.partId,
    required this.majorId,
    required this.yearOfStudy,
    required this.courses,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'partId': partId,
      'majorId': majorId,
      'yearOfStudy': yearOfStudy,
      'courses': courses.map((course) => course.toMap()).toList(),
    };
  }

  // Factory method to create Part from Firebase data
  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      partId: map['partId'],
      majorId: map['majorId'],
      yearOfStudy: map['yearOfStudy'],
      courses: List<Course>.from(
        map['courses'].map((courseData) => Course.fromMap(courseData)),
      ),
    );
  }
}
