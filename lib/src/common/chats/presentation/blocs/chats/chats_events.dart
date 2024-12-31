import 'package:studify/core/utils/enums.dart';

import '../../../data/models/participant_model.dart';

abstract class ChatsEvent {
  const ChatsEvent();
}

class FetchChats extends ChatsEvent {
  final String userId;
  final String filiereId;

  FetchChats({
    required this.userId,
    required this.filiereId,
  });
}

class StartChat extends ChatsEvent {
  final ChatType type; // "individual" or "group"
  final Map<String, Participant> participants; // List of user IDs

  const StartChat({required this.type, required this.participants});
}

class SendMessage extends ChatsEvent {
  final String chatId;
  final String message; // Message content (not a ChatType)
  final String messageType; // "text", "file", "voice"
  final String senderId;
  final String? attachmentUrl; // Optional for files/voice
  final String? fileName; // Optional for files
  final int? fileSize; // Optional for files
  final int? duration; // Optional for voice messages

  const SendMessage({
    required this.chatId,
    required this.senderId,
    required this.message,
    required this.messageType,
    this.attachmentUrl,
    this.fileName,
    this.fileSize,
    this.duration,
  });
}

class EditMessage extends ChatsEvent {
  final String chatId;
  final String messageId;
  final String newMessage;

  const EditMessage({
    required this.chatId,
    required this.messageId,
    required this.newMessage,
  });
}

class MarkMessagesAsRead extends ChatsEvent {
  final String chatId;
  final String senderId;

  MarkMessagesAsRead({
    required this.chatId,
    required this.senderId,
  });
}
