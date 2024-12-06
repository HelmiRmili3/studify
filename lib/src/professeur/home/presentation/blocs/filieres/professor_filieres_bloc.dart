import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/professor_repository.dart';
import 'professor_filieres_events.dart';
import 'professor_filieres_states.dart';

class ProfessorFilieresBloc
    extends Bloc<ProfessorFilieresEvents, ProfessorFilieresStates> {
  final HomeRepository repository = HomeRepository();

  ProfessorFilieresBloc() : super(FilieresInitial()) {
    on<LoadFilieres>((event, emit) async {
      emit(FilieresLoading());
      try {
        await emit.forEach(
          repository.streamFilieres(),
          onData: (matieres) => FilieresLoaded(matieres),
          onError: (error, stackTrace) => FilieresError(error.toString()),
        );
      } catch (e) {
        emit(FilieresError(e.toString()));
      }
    });
  }
}
