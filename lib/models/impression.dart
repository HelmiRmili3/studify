class Impression {
  final String impressionId; // Unique ID for the impression (Firebase doc ID)
  final String studentId; // ID of the student who made the impression
  final String courseId; // ID of the course being liked or disliked
  final bool isLiked; // True if liked, false if disliked
  final DateTime createdAt; // When the impression was made
  final DateTime updatedAt; // When the impression was last updated

  Impression({
    required this.impressionId,
    required this.studentId,
    required this.courseId,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'impressionId': impressionId,
      'studentId': studentId,
      'courseId': courseId,
      'isLiked': isLiked,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Factory method to create Impression from Firebase data
  factory Impression.fromMap(Map<String, dynamic> map) {
    return Impression(
      impressionId: map['impressionId'],
      studentId: map['studentId'],
      courseId: map['courseId'],
      isLiked: map['isLiked'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
