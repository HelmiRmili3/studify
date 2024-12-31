import '../../../data/models/chat_model.dart';

abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  final List<ChatModel> chats;

  ChatsLoaded({
    required this.chats,
  });
}

class ChatMessagesLoaded extends ChatsState {
  final String chatId;
  final List<Map<String, dynamic>> messages;
  ChatMessagesLoaded({
    required this.chatId,
    required this.messages,
  });
}

class ChatsError extends ChatsState {
  final String error;

  ChatsError({required this.error});
}
