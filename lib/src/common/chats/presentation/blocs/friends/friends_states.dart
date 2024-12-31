import 'package:studify/src/common/auth/data/models/user_data_model.dart';

abstract class FriendsState {}

class FriendsInitial extends FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoaded extends FriendsState {
  final List<UserDataModel> friends;

  FriendsLoaded({required this.friends});
}

class FriendsError extends FriendsState {
  final String error;

  FriendsError({required this.error});
}
