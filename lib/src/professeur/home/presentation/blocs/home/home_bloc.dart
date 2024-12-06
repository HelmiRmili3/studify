import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/professor_repository.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final HomeRepository repository = HomeRepository();

  HomeBloc() : super(MatieresInitial()) {
    on<LoadMatieres>((event, emit) async {
      emit(MatieresLoading());
      try {
        await emit.forEach(
          repository.streamMatieres(),
          onData: (matieres) => MatieresLoaded(matieres),
          onError: (error, stackTrace) => MatieresError(error.toString()),
        );
      } catch (e) {
        emit(MatieresError(e.toString()));
      }
    });
  }
}
