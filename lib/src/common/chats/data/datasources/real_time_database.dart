import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:studify/core/utils/enums.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/participant_model.dart';

class RealTimeDatabase {
  RealTimeDatabase();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> createChat({
    required String chatId,
    required ChatType type,
    required Map<String, Participant> participants,
  }) async {
    try {
      // Reference to the "chats" node in Firebase
      final DatabaseReference chatsRef = FirebaseDatabase.instance.ref("chats");

      // Create initial chat data
      final ChatModel newChat = ChatModel(
        chatId: chatId,
        type: type,
        participants: participants,
        lastInteraction: DateTime.now().toIso8601String(),
        lastMessage: Message(
          message: '',
          senderId: '',
          timestamp: '',
          type: 'text',
        ),
        messages: {},
      );

      // Convert chat data to JSON
      final Map<String, dynamic> chatJson = newChat.toJson();

      // Store the chat data in Firebase
      await chatsRef.child(chatId).set(chatJson);

      debugPrint('New chat created successfully with ID: $chatId');
    } catch (e) {
      debugPrint('Error creating new chat: $e');
    }
  }

  // Add a message to a chat
  Future<void> addMessage({
    required String chatId,
    required String senderId,
    required String message,
    required String type, // "text", "file", or "voice"
    String? attachmentUrl,
    String? fileName,
    int? fileSize,
    int? duration, // for voice messages
  }) async {
    try {
      final messagesRef = _database.ref("chats/$chatId/messages");
      final newMessageRef = messagesRef.push();
      final timestamp = DateTime.now().toIso8601String();

      final messageData = {
        "senderId": senderId,
        "message": message,
        "type": type,
        "timestamp": timestamp,
        if (attachmentUrl != null) "attachmentUrl": attachmentUrl,
        if (fileName != null) "fileName": fileName,
        if (fileSize != null) "fileSize": fileSize,
        if (duration != null) "duration": duration,
      };

      await newMessageRef.set(messageData);

      // Update the unread count for participants except the sender
      final participantsRef = _database.ref("chats/$chatId/participants");

      // Get current participants data
      final participantsSnapshot = await participantsRef.once();
      final participantsData = participantsSnapshot.snapshot.value;

      // Log the actual structure of the participants data for debugging
      debugPrint("Participants Data: $participantsData");

      // Check if participants data is a Map
      // Check if participants data is a Map
      if (participantsData is Map) {
        // Convert the Map to the expected type
        final participants = participantsData.map((key, value) =>
            MapEntry(key.toString(), Map<String, dynamic>.from(value as Map)));

        // Iterate over participants
        for (var participantId in participants.keys) {
          final participantData = participants[participantId];

          // Only update unread count if the participant is not the sender
          if (participantId != senderId) {
            final unreadCount = participantData?["unreadCount"] ?? 0;
            participantsRef.child(participantId).update({
              "unreadCount": unreadCount + 1, // Increment unread count
              "lastRead": DateTime.now().toIso8601String(),
            });
          }
        }
      } else {
        debugPrint("Participants data is not in the expected format.");
      }

      // Update lastMessage and lastInteraction
      final chatRef = _database.ref("chats/$chatId");
      await chatRef.update({
        "lastMessage": messageData,
        "lastInteraction": timestamp,
      });
    } catch (e) {
      debugPrint("Error adding message: $e");
    }
  }

  // Edit a message
  Future<void> editMessage({
    required String chatId,
    required String messageId,
    required String updatedMessage,
  }) async {
    try {
      final messageRef = _database.ref("chats/$chatId/messages/$messageId");
      await messageRef.update({"message": updatedMessage});
    } catch (e) {
      debugPrint("Error editing message: $e");
    }
  }

  // Delete a message
  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    try {
      final messageRef = _database.ref("chats/$chatId/messages/$messageId");
      await messageRef.remove();
    } catch (e) {
      debugPrint("Error deleting message: $e");
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead({
    required String chatId,
    required String userId,
  }) async {
    try {
      final participantRef =
          _database.ref("chats/$chatId/participants/$userId");
      await participantRef.update({
        "unreadCount": 0,
        "lastRead": DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint("Error marking messages as read: $e");
    }
  }

  Stream<List<ChatModel>> getChatsStream() {
    final DatabaseReference chatsRef = FirebaseDatabase.instance.ref("chats");

    // Listen to real-time updates
    return chatsRef.onValue.map((DatabaseEvent event) {
      // Ensure the value is not null and can be cast to a Map
      final data = event.snapshot.value;
      if (data == null || data is! Map<dynamic, dynamic>) {
        return [];
      }

      try {
        // Now that we've safely cast the data to a Map, we can proceed
        final Map<dynamic, dynamic> dataMap = data;

        // Convert to list of Chat objects
        return dataMap.entries.map((entry) {
          final chatJson =
              Map<String, dynamic>.from(entry.value as Map<dynamic, dynamic>);

          // Convert participants
          final participants = (chatJson['participants']
                      as Map<dynamic, dynamic>?)
                  ?.map((key, value) => MapEntry(
                        key as String,
                        Participant.fromJson(Map<String, dynamic>.from(value)),
                      )) ??
              {};

          // Convert messages
          final messages = (chatJson['messages'] as Map<dynamic, dynamic>?)
                  ?.map((key, value) => MapEntry(
                        key as String,
                        Message.fromJson(Map<String, dynamic>.from(value)),
                      )) ??
              {};

          return ChatModel(
            chatId: chatJson['chatId'] as String,
            type: ChatType.values.firstWhere(
              (e) => e.name == chatJson['type'],
              orElse: () => ChatType.individual, // Default to individual
            ),
            participants: participants,
            lastInteraction: chatJson['lastInteraction'] as String,
            lastMessage: Message.fromJson(
              Map<String, dynamic>.from(chatJson['lastMessage']),
            ),
            messages: messages,
          );
        }).toList();
      } catch (e) {
        debugPrint('Error parsing real-time chats: $e');
        return [];
      }
    });
  }
}
