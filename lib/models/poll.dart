class Poll {
  final String pollId; // Unique ID for the poll
  final String question; // The question being asked
  final List<String> options; // List of possible options to vote for
  final String creatorId; // ID of the poll creator (student/admin)
  final List<String> restrictedMajors; // List of majors allowed to participate
  final List<String>
      restrictedRoles; // List of roles allowed (e.g., 'student', 'professor')
  final Map<String, String> votes; // Map of studentId -> selected option
  final DateTime createdAt; // Timestamp for poll creation
  final DateTime expiresAt; // Expiration timestamp for the poll

  Poll({
    required this.pollId,
    required this.question,
    required this.options,
    required this.creatorId,
    required this.restrictedMajors,
    required this.restrictedRoles,
    required this.votes,
    required this.createdAt,
    required this.expiresAt,
  });

  // Convert Poll to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'pollId': pollId,
      'question': question,
      'options': options,
      'creatorId': creatorId,
      'restrictedMajors': restrictedMajors,
      'restrictedRoles': restrictedRoles,
      'votes': votes,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
    };
  }

  // Factory method to create Poll from Firebase data
  factory Poll.fromMap(Map<String, dynamic> map) {
    return Poll(
      pollId: map['pollId'],
      question: map['question'],
      options: List<String>.from(map['options']),
      creatorId: map['creatorId'],
      restrictedMajors: List<String>.from(map['restrictedMajors']),
      restrictedRoles: List<String>.from(map['restrictedRoles']),
      votes: Map<String, String>.from(map['votes']),
      createdAt: DateTime.parse(map['createdAt']),
      expiresAt: DateTime.parse(map['expiresAt']),
    );
  }
}
