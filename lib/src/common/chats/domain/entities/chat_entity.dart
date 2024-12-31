import '../../../../../core/utils/enums.dart';
import '../../data/models/message_model.dart';
import '../../data/models/participant_model.dart';

class ChatEntity {
  String chatId;
  ChatType type;
  Map<String, Participant> participants;
  String lastInteraction;
  Message lastMessage;
  Map<String, Message> messages;

  ChatEntity({
    required this.chatId,
    required this.type,
    required this.participants,
    required this.lastInteraction,
    required this.lastMessage,
    required this.messages,
  });
}
