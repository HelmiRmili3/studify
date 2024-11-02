class Course {
  final String courseId; // Unique ID for the course
  final String courseName; // Name of the course (e.g., Algorithms)
  final String courseCode; // Code of the course (e.g., CS101)
  final double totalHours; // Total hours for the course
  final String description; // Short description of the course

  Course({
    required this.courseId,
    required this.courseName,
    required this.courseCode,
    required this.totalHours,
    required this.description,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseCode': courseCode,
      'totalHours': totalHours,
      'description': description,
    };
  }

  // Factory method to create Course from Firebase data
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['courseId'],
      courseName: map['courseName'],
      courseCode: map['courseCode'],
      totalHours: map['totalHours'],
      description: map['description'],
    );
  }
}
