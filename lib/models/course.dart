class Course {
  final String courseId; // Unique ID for the course
  final String courseName; // Name of the course (e.g., Algorithms)
  final String courseCode; // Code of the course (e.g., CS101)
  final String description; // Short description of the course

  Course({
    required this.courseId,
    required this.courseName,
    required this.courseCode,
    required this.description,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseCode': courseCode,
      'description': description,
    };
  }

  // Factory method to create Course from Firebase data
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['courseId'],
      courseName: map['courseName'],
      courseCode: map['courseCode'],
      description: map['description'],
    );
  }
}
