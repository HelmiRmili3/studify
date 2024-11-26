import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/matieres/matiers_events.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/matieres/matiers_states.dart';

import '../../../data/repositories/matiere_repository.dart';

class MatiersBloc extends Bloc<MatiersEvent, MatiersState> {
  final MatiereRepository repository = MatiereRepository();
  MatiersBloc() : super(MatieresInitial()) {
    on<LoadMatieres>((event, emit) async {
      emit(MatieresLoading());
      try {
        await emit.forEach(
          repository.fetchMatieres(event.niveauId),
          onData: (matiers) => MatieresLoaded(matiers),
          onError: (error, stackTrace) => MatieresError(error.toString()),
        );
      } catch (e) {
        emit(MatieresError(e.toString()));
      }
    });
    on<AddMatiere>((event, emit) async {
      emit(MatieresLoading());
      try {
        await repository.addMatiere(event.matiere);
        MatiereAdded();
      } catch (e) {
        emit(MatieresError(e.toString()));
      }
    });
  }
}
