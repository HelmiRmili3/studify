import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/src/common/auth/data/models/user_data_model.dart';
import '../datasources/real_time_database.dart';
import '../../../../../core/utils/firestore.dart';
import '../../../../admin/filiers/data/repositories/niveau_repository.dart';
import '../models/chat_model.dart';
import '../models/participant_model.dart';

class ChatsRepository {
  final RealTimeDatabase _realTimeDatabase = RealTimeDatabase();
  final NiveauRepository niveauRepository = NiveauRepository();
  ChatsRepository();

// Fetch chats from Firebase Realtime Database
  Stream<List<ChatModel>> fetchChats() {
    try {
      return _realTimeDatabase.getChatsStream();
    } catch (e) {
      throw Exception("Error fetching chats: $e");
    }
  }

  Future<List<UserDataModel>> fetchNiveau(String code) async {
    try {
      // Fetch the niveaux document to get the list of student IDs
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection(Firestore.years)
              .doc('2024')
              .collection(Firestore.niveaux)
              .doc(code)
              .get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        // Extract the list of student IDs
        List<dynamic> userIds = docSnapshot.data()!['emails'] as List<dynamic>;

        // Fetch users asynchronously
        List<Future<UserDataModel?>> usersFutures = userIds.map((id) async {
          DocumentSnapshot<Map<String, dynamic>> userSnapshot =
              await FirebaseFirestore.instance
                  .collection(Firestore.users)
                  .doc(id)
                  .get();

          if (userSnapshot.exists && userSnapshot.data() != null) {
            return UserDataModel.fromJson(userSnapshot.data()!);
          } else {
            return null;
          }
        }).toList();

        // Resolve futures and filter out null values
        List<UserDataModel?> usersModels = await Future.wait(usersFutures);
        List<UserDataModel> validUsersModels =
            usersModels.whereType<UserDataModel>().toList();

        // Separate users into students and professors
        List<UserDataModel> students = validUsersModels
            .where((user) => user.role == UserRole.student)
            .toList();

        List<UserDataModel> professors = validUsersModels
            .where((user) => user.role == UserRole.professor)
            .toList();

        // Combine students and professors
        List<UserDataModel> friends = [...students, ...professors];

        // Return the result
        return friends;
      } else {
        // If no document found, return empty data
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching niveau: $e");
      return [];
    }
  }

  // Start a new chat (Group or One-to-One)
  Future<void> startChat({
    required chatId,
    required ChatType type, // ChatType.individual or ChatType.group
    required Map<String, Participant> participants,
  }) async {
    try {
      await _realTimeDatabase.createChat(
        chatId: chatId,
        type: type,
        participants: participants,
      );
    } catch (e) {
      throw Exception("Error starting chat: $e");
    }
  }

  // Send a message to a chat
  Future<void> sendMessage({
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
      await _realTimeDatabase.addMessage(
        chatId: chatId,
        senderId: senderId,
        message: message,
        type: type,
        attachmentUrl: attachmentUrl,
        fileName: fileName,
        fileSize: fileSize,
        duration: duration,
      );
    } catch (e) {
      throw Exception("Error sending message: $e");
    }
  }

  // Edit an existing message
  Future<void> editMessage({
    required String chatId,
    required String messageId,
    required String updatedMessage,
  }) async {
    try {
      await _realTimeDatabase.editMessage(
        chatId: chatId,
        messageId: messageId,
        updatedMessage: updatedMessage,
      );
    } catch (e) {
      throw Exception("Error editing message: $e");
    }
  }

  // Delete a message from a chat
  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    try {
      await _realTimeDatabase.deleteMessage(
        chatId: chatId,
        messageId: messageId,
      );
    } catch (e) {
      throw Exception("Error deleting message: $e");
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead({
    required String chatId,
    required String userId,
  }) async {
    try {
      await _realTimeDatabase.markMessagesAsRead(
        chatId: chatId,
        userId: userId,
      );
    } catch (e) {
      throw Exception("Error marking messages as read: $e");
    }
  }
}
