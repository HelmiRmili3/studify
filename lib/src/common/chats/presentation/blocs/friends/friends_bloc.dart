import 'package:bloc/bloc.dart';
import '../../../../auth/data/models/user_data_model.dart';
import '../../../data/repositories/chats_repository.dart';
import 'friends_events.dart';
import 'friends_states.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final ChatsRepository _chatsRepository = ChatsRepository();
  List<UserDataModel> friends = [];

  FriendsBloc(FetchFriends fetchFriends) : super(FriendsInitial()) {
    on<FetchFriends>(_onFetchFriends);
  }

  void _onFetchFriends(FetchFriends event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      List<UserDataModel> data =
          await _chatsRepository.fetchNiveau(event.filiereId);
      friends = data;
      emit(FriendsLoaded(friends: friends));
    } catch (e) {
      emit(FriendsError(error: e.toString()));
    }
  }
}
