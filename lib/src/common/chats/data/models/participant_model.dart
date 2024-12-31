class Participant {
  int unreadCount;
  String lastRead; // Timestamp of the last read message

  Participant({
    required this.unreadCount,
    required this.lastRead,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      unreadCount: json['unreadCount'],
      lastRead: json['lastRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unreadCount': unreadCount,
      'lastRead': lastRead,
    };
  }
}
