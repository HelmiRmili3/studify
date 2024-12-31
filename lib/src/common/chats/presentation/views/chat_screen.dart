import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/injection/dependency_injection.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/src/common/chats/presentation/blocs/chats/chats_bloc.dart';
import 'package:studify/src/common/chats/presentation/blocs/chats/chats_events.dart';
import 'package:studify/src/common/chats/presentation/blocs/chats/chats_states.dart';

import '../../../../../core/common/blocs/user/user_bloc.dart';
import '../../../../../models/user.dart';
import '../../../auth/data/models/user_data_model.dart';
import '../blocs/friends/friends_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String chatName;
  const ChatScreen({
    super.key,
    required this.chatId,
    required this.chatName,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  late UserModel? currentUser;
  late ChatsBloc chatsBloc;
  late UserBloc userBloc;
  @override
  void initState() {
    super.initState();
    currentUser = locator<UserBloc>().user;
    locator<ChatsBloc>().add(MarkMessagesAsRead(
      chatId: widget.chatId,
      senderId: currentUser!.uid,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    chatsBloc = context.read<ChatsBloc>();
  }

  @override
  void dispose() {
    chatsBloc.add(MarkMessagesAsRead(
      chatId: widget.chatId,
      senderId: currentUser!.uid,
    ));

    _messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Center(child: Text('User not found.'));
    }

    return Scaffold(
      appBar: CustomAppBar(title: widget.chatName),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatsBloc, ChatsState>(
              builder: (context, state) {
                if (state is ChatsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatsError) {
                  return Center(child: Text(state.error));
                } else if (state is ChatsLoaded) {
                  final chat =
                      state.chats.firstWhere((e) => e.chatId == widget.chatId);
                  final messages = chat.messages.entries.toList()
                    ..sort((a, b) =>
                        b.value.timestamp.compareTo(a.value.timestamp));

                  final friendId = chat.participants.keys
                      .firstWhere((e) => e != currentUser!.uid);

                  final him = chat.participants[friendId];

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index].value;
                        final isSender = message.senderId == currentUser!.uid;
                        final isLastMessageSameSenderId = index > 0
                            ? messages[index - 1].value.senderId
                            : null;
                        final isNextMessageSameSenderId =
                            index < messages.length - 1
                                ? messages[index + 1].value.senderId
                                : null;

                        final bool isTopCorner =
                            isLastMessageSameSenderId != message.senderId;
                        final bool isBottomCorner =
                            isNextMessageSameSenderId != message.senderId;

                        final double cornerRadius = 16.0.r;

                        UserDataModel? friend;
                        if (!isSender) {
                          final friends = context.read<FriendsBloc>().friends;
                          String friendId = message.senderId;
                          friend = friends.firstWhere((e) => e.id != friendId);
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: isSender
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isSender &&
                                    friend != null &&
                                    friend.imageUrl != null)
                                  isTopCorner
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0.r),
                                          child: Image.network(
                                            friend.imageUrl!,
                                            width: 32,
                                            height: 32,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const SizedBox(width: 32),
                                // Message bubble
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: isSender
                                        ? Colors.blueAccent
                                        : Colors.grey[300],
                                    borderRadius: isSender
                                        ? BorderRadius.only(
                                            topLeft:
                                                Radius.circular(cornerRadius),
                                            bottomLeft:
                                                Radius.circular(cornerRadius),
                                            topRight: isBottomCorner
                                                ? Radius.circular(cornerRadius)
                                                : const Radius.circular(0.0),
                                            bottomRight: isTopCorner
                                                ? Radius.circular(cornerRadius)
                                                : const Radius.circular(0.0),
                                          )
                                        : BorderRadius.only(
                                            topLeft: isBottomCorner
                                                ? Radius.circular(cornerRadius)
                                                : const Radius.circular(0.0),
                                            bottomLeft: isTopCorner
                                                ? Radius.circular(cornerRadius)
                                                : const Radius.circular(0.0),
                                            topRight:
                                                Radius.circular(cornerRadius),
                                            bottomRight:
                                                Radius.circular(cornerRadius),
                                          ),
                                  ),
                                  child: Text(
                                    message.message,
                                    style: TextStyle(
                                      color: isSender
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (him != null)
                              if (!isSender && index == him.unreadCount)
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 8.w, bottom: 2.h),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0.r),
                                    child: Image.network(
                                      friend!.imageUrl!,
                                      width: 18.sp,
                                      height: 18.sp,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  );
                }
                return const Center(child: Text('No messages'));
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attachment),
                    onPressed: () {
                      // Add attachment action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      // Add camera action
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final message = _messageController.text;
                      if (message.isNotEmpty) {
                        context.read<ChatsBloc>().add(SendMessage(
                              chatId: widget.chatId,
                              message: message,
                              messageType: ChatType.individual.name,
                              senderId: currentUser!.uid,
                              attachmentUrl: null,
                              fileName: null,
                              fileSize: null,
                              duration: null,
                            ));
                        _messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
