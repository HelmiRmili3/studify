import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:studify/core/utils/helpers.dart';

import '../../../../../core/common/blocs/user/user_bloc.dart';
import '../../../../../core/common/widgets/fading_circle_loading_indicator.dart';
import '../../../../../core/injection/dependency_injection.dart';
import '../../../../../core/service/secure_storage_service.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../models/user.dart';
import '../../../auth/data/models/user_data_model.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/participant_model.dart';
import '../blocs/chats/chats_bloc.dart';
import '../blocs/chats/chats_events.dart';
import '../blocs/chats/chats_states.dart';
import '../blocs/friends/friends_bloc.dart';
import '../blocs/friends/friends_events.dart';
import '../blocs/friends/friends_states.dart';
import 'chat_screen.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  AllChatsScreenState createState() => AllChatsScreenState();
}

class AllChatsScreenState extends State<AllChatsScreen> {
  final PageController _pageController = PageController();
  final UserProfileStorage userProfileStorage = UserProfileStorage();
  late UserModel? currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = locator<UserBloc>().user;
    locator<ChatsBloc>()
        .add(FetchChats(filiereId: 'LAM1', userId: currentUser!.uid));
    locator<FriendsBloc>().add(FetchFriends(filiereId: 'LAM1'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: PageView(
        controller: _pageController,
        children: [
          // Page 1: Chats Page
          BlocBuilder<ChatsBloc, ChatsState>(
            builder: (context, state) {
              if (state is ChatsLoading) {
                return const Center(child: FadingCircleLoadingIndicator());
              } else if (state is ChatsError) {
                return Center(child: Text(state.error));
              } else if (state is ChatsLoaded) {
                if (state.chats.isEmpty) {
                  return const Center(child: Text('No chats available.'));
                }
                // Filter the chats to only show the ones where the current user is a participant
                final filteredChats = state.chats.where((chat) {
                  return chat.participants.containsKey(currentUser!.uid);
                }).toList();

                if (filteredChats.isEmpty) {
                  return const Center(child: Text('No chats available.'));
                }

                // Sort chats by lastMessage.timestamp in descending order
                filteredChats.sort((a, b) {
                  final aTimestamp = DateTime.parse(a.lastMessage.timestamp);
                  final bTimestamp = DateTime.parse(b.lastMessage.timestamp);
                  return bTimestamp.compareTo(aTimestamp);
                });

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];
                    final lastMessage = chat.lastMessage;
                    final isMe = lastMessage.senderId == currentUser!.uid;
                    var friends = context.read<FriendsBloc>().friends;
                    if (friends.isEmpty) {
                      return const Center(child: Text('No friends found.'));
                    }

                    String friendId = chat.participants.keys.firstWhere(
                      (participantId) => participantId != currentUser!.uid,
                    );

                    UserDataModel? friend;
                    try {
                      friend = friends.firstWhere((e) => e.id == friendId);
                    } catch (e) {
                      return const Center(
                          child: Text('No valid friend found.'));
                    }

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.network(
                          friend.imageUrl!,
                          width: 50.r,
                          height: 50.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        '${friend.firstName.capitalizeFirst()} ${friend.lastName.capitalizeFirst()}',
                        style: TextStyle(
                          fontWeight: _getUnreadCount(chat) > 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: chat.lastMessage.message.isEmpty
                          ? const Text("Send the first message.")
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                isMe
                                    ? const Text("You: ")
                                    : const SizedBox.shrink(),
                                SizedBox(width: 2.w),
                                Flexible(
                                  child: Text(
                                    lastMessage.message,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: _getUnreadCount(chat) > 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Transform.translate(
                                  offset: const Offset(0, -3),
                                  child: Text(
                                    ".",
                                    style: TextStyle(
                                      fontWeight: _getUnreadCount(chat) > 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  formatTimestamp(lastMessage.timestamp),
                                  style: TextStyle(
                                    fontWeight: _getUnreadCount(chat) > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_getUnreadCount(chat) > 0)
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                _getUnreadCount(chat).toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              chatId: chat.chatId,
                              chatName:
                                  '${friend!.firstName.capitalizeFirst()} ${friend.lastName.capitalizeFirst()}',
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              return const Center(child: Text('No chats available'));
            },
          ),
          // Page 2: Friends Page
          BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, state) {
              if (state is FriendsLoading) {
                return const Center(child: FadingCircleLoadingIndicator());
              } else if (state is FriendsError) {
                return Center(child: Text(state.error));
              } else if (state is FriendsLoaded) {
                if (state.friends.isEmpty) {
                  return const Center(child: Text('No friends available.'));
                }
                final friendslist = state.friends;
                final friends = friendslist
                    .where((friend) => friend.id != currentUser!.uid)
                    .toList();

                final chats = context.read<ChatsBloc>().chats;
                final filteredChats = chats.where((chat) {
                  return chat.participants.containsKey(currentUser!.uid);
                }).toList();

                return ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final friend = friends[index];
                    final found = filteredChats.any((chat) {
                      return chat.participants.containsKey(friend.id);
                    });
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0.r),
                        child: Image.network(
                          friend.imageUrl!,
                          width: 50.r,
                          height: 50.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        '${friend.firstName.capitalizeFirst()} ${friend.lastName.capitalizeFirst()}',
                      ),
                      subtitle: const Text("Tap to start chat"),
                      trailing: !found
                          ? ElevatedButton(
                              onPressed: () {
                                Map<String, Participant> participants = {
                                  friend.id: Participant(
                                      unreadCount: 0,
                                      lastRead:
                                          DateTime.now().toIso8601String()),
                                  currentUser!.uid: Participant(
                                      unreadCount: 0,
                                      lastRead:
                                          DateTime.now().toIso8601String()),
                                };
                                context.read<ChatsBloc>().add(
                                      StartChat(
                                        type: ChatType.individual,
                                        participants: participants,
                                      ),
                                    );
                              },
                              child: const Text("Start Chat"),
                            )
                          : IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert),
                            ),
                    );
                  },
                );
              }
              return const Center(child: Text('No friends available'));
            },
          ),
        ],
      ),
    );
  }

  int _getUnreadCount(ChatModel chat) {
    final participant = chat.participants[currentUser!.uid];
    return participant?.unreadCount ?? 0;
  }
}

String formatTimestamp(String? timestamp) {
  if (timestamp == null || timestamp.isEmpty) {
    return '';
  }

  try {
    final messageTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    final difference = now.difference(messageTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return DateFormat('h:mm a').format(messageTime);
    } else if (difference.inHours < 24) {
      return DateFormat('h:mm a').format(messageTime);
    } else if (difference.inDays < 7) {
      return DateFormat('EEE').format(messageTime);
    } else if (difference.inDays < 365) {
      return DateFormat('MMM d').format(messageTime);
    } else {
      return DateFormat('yyyy MMM d').format(messageTime);
    }
  } catch (e) {
    debugPrint('Error formatting timestamp: $e');
    return 'Invalid date';
  }
}
