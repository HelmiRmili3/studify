import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/repositories/chats_repository.dart';
import 'chats_events.dart';
import 'chats_states.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatsRepository _chatsRepository = ChatsRepository();
  List<ChatModel> chats = [];
  ChatsBloc() : super(ChatsInitial()) {
    on<FetchChats>(_onFetchChats);
    on<StartChat>(_onStartChat);
    on<SendMessage>(_onSendMessage);
    on<EditMessage>(_onEditMessage);
    on<MarkMessagesAsRead>(_onMarkMessagesAsRead);
  }

  Future<void> _onFetchChats(FetchChats event, Emitter<ChatsState> emit) async {
    emit(ChatsLoading());
    try {
      await emit.forEach(
        _chatsRepository.fetchChats(),
        onData: (data) {
          chats = data;
          return ChatsLoaded(chats: data);
        },
        onError: (error, stackTrace) => ChatsError(error: error.toString()),
      );
    } catch (e) {
      emit(ChatsError(error: e.toString()));
    }
  }

  Future<void> _onStartChat(StartChat event, Emitter<ChatsState> emit) async {
    try {
      final chatId = const Uuid().v1();
      await _chatsRepository.startChat(
        chatId: chatId,
        type: event.type,
        participants: event.participants,
      );
    } catch (e) {
      emit(ChatsError(error: e.toString()));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatsState> emit) async {
    try {
      await _chatsRepository.sendMessage(
        chatId: event.chatId,
        senderId: event.senderId,
        message: event.message,
        type: event.messageType,
        attachmentUrl: event.attachmentUrl,
        fileName: event.fileName,
        fileSize: event.fileSize,
        duration: event.duration,
      );
    } catch (e) {
      emit(ChatsError(error: e.toString()));
    }
  }

  Future<void> _onEditMessage(
      EditMessage event, Emitter<ChatsState> emit) async {
    try {
      await _chatsRepository.editMessage(
        chatId: event.chatId,
        messageId: event.messageId,
        updatedMessage: event.newMessage,
      );
    } catch (e) {
      emit(ChatsError(error: e.toString()));
    }
  }

  Future<void> _onMarkMessagesAsRead(
      MarkMessagesAsRead event, Emitter<ChatsState> emit) async {
    try {
      _chatsRepository.markMessagesAsRead(
        chatId: event.chatId,
        userId: event.senderId,
      );
    } catch (e) {
      emit(ChatsError(error: e.toString()));
    }
  }
}
