class Message {
  String senderId;
  String message;
  String type; // "text", "file", "voice"
  String timestamp; // Timestamp of when the message was sent
  String? attachmentUrl; // URL to the file (only for file type)
  String? fileName; // Filename of the attachment (only for file type)
  int? fileSize; // Size of the file (only for file type)
  String? voiceUrl; // URL to the voice message (only for voice type)
  int? duration;

  Message({
    required this.senderId,
    required this.message,
    required this.type,
    required this.timestamp,
    this.attachmentUrl,
    this.fileName,
    this.fileSize,
    this.voiceUrl,
    this.duration,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      message: json['message'],
      type: json['type'],
      timestamp: json['timestamp'],
      attachmentUrl: json['attachmentUrl'],
      fileName: json['fileName'],
      fileSize: json['fileSize'],
      voiceUrl: json['voiceUrl'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'message': message,
      'type': type,
      'timestamp': timestamp,
      'attachmentUrl': attachmentUrl,
      'fileName': fileName,
      'fileSize': fileSize,
      'voiceUrl': voiceUrl,
      'duration': duration,
    };
  }
}
