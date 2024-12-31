import 'package:studify/core/utils/enums.dart';

import '../../domain/entities/chat_entity.dart';
import 'message_model.dart';
import 'participant_model.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.chatId,
    required super.type,
    required super.participants,
    required super.lastInteraction,
    required super.lastMessage,
    required super.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    var participantsFromJson = Map<String, Participant>.from(
      (json['participants'] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, Participant.fromJson(value as Map<String, dynamic>)),
      ),
    );

    var messagesFromJson = Map<String, Message>.from(
      (json['messages'] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, Message.fromJson(value as Map<String, dynamic>)),
      ),
    );

    return ChatModel(
      chatId: json['chatId'] as String,
      type: ChatType.values.byName(json['type']),
      participants: participantsFromJson,
      lastInteraction: json['lastInteraction'] as String,
      lastMessage: Message.fromJson(json['lastMessage']),
      messages: messagesFromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'type': type.name,
      'participants':
          participants.map((key, value) => MapEntry(key, (value).toJson())),
      'lastInteraction': lastInteraction,
      'lastMessage': (lastMessage).toJson(),
      'messages': messages.map((key, value) => MapEntry(key, (value).toJson())),
    };
  }
}
