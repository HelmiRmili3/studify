import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/filiere_repository.dart';
import 'filiere_events.dart';
import 'filiere_states.dart';

class FiliereBloc extends Bloc<FiliereEvent, FiliereState> {
  final FiliereRepository repository = FiliereRepository();

  FiliereBloc() : super(FiliereInitial()) {
    on<LoadFilieres>((event, emit) async {
      emit(FiliereLoading());
      try {
        await emit.forEach(
          repository.streamFilieres(),
          onData: (filieres) => FiliereLoaded(filieres),
          onError: (error, stackTrace) => FiliereError(error.toString()),
        );
      } catch (e) {
        emit(FiliereError(e.toString()));
      }
    });

    on<AddFiliere>((event, emit) {
      emit(FiliereAdding());
      try {
        repository.addFiliere(event.filiere);
        emit(FiliereAdded());
      } catch (e) {
        emit(FiliereError(e.toString()));
      }
    });

    on<UpdateFiliere>((event, emit) {
      try {
        repository.updateFiliere(event.filiere);
        emit(FiliereOperationSuccess());
      } catch (e) {
        emit(FiliereError(e.toString()));
      }
    });

    on<DeleteFiliere>((event, emit) {
      try {
        repository.deleteFiliere(event.code);
        emit(FiliereOperationSuccess());
      } catch (e) {
        emit(FiliereError(e.toString()));
      }
    });
  }
}
