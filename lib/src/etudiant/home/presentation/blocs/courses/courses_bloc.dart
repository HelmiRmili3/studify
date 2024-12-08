import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/src/etudiant/home/domain/repositories/student_matieres_repository.dart';

import 'courses_events.dart';
import 'courses_states.dart';

class CoursesBloc extends Bloc<CoursesEvents, CoursesStates> {
  final StudentMatieresRepository repository = StudentMatieresRepository();

  CoursesBloc() : super(MatieresInitial()) {
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
