import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/student_matieres_repository.dart';
import 'professors_events.dart';
import 'professors_states.dart';

class ProfessorsBloc extends Bloc<ProfessorsEvents, ProfessorsStates> {
  final StudentMatieresRepository repository = StudentMatieresRepository();
  ProfessorsBloc() : super(ProfessorsInitial()) {
    on<LoadProfessors>((event, emit) async {
      emit(LoadingProfessors());
      try {
        await emit.forEach(
          repository.streamProfessors(),
          onData: (professors) => ProfessorsLoaded(professors),
          onError: (error, stackTrace) => ErrorProfessors(error.toString()),
        );
      } catch (e) {
        emit(ErrorProfessors(e.toString()));
      }
    });
  }
}
