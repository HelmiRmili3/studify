abstract class FriendsEvent {
  const FriendsEvent();
}

class FetchFriends extends FriendsEvent {
  final String filiereId;
  FetchFriends({required this.filiereId});
}
