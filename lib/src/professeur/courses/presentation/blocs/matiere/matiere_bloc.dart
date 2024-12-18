import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/src/professeur/courses/presentation/blocs/matiere/matiere_states.dart';
import '../../../domain/repositories/matiere_repository.dart';
import 'matiere_events.dart';

class MatiereBloc extends Bloc<MatiereEvents, MatiereStates> {
  final MatiereRepository repository = MatiereRepository();

  MatiereBloc() : super(MatiereInitial()) {
    on<LoadDocs>((event, emit) async {
      emit(MatiereInitial());
      try {
        await emit.forEach(
          repository.fetchDocsByFilters(event.filters),
          onData: (filieres) => MatiereLoaded(filieres),
          onError: (error, stackTrace) => MatiereError(error.toString()),
        );
      } catch (e) {
        emit(MatiereError(e.toString()));
      }
    });

    on<AddDoc>((event, emit) {
      emit(DocAdding());
      try {
        repository.addDoc(
          event.doc,
          event.files,
        );
        emit(DocAdded());
      } catch (e) {
        emit(DocError(e.toString()));
      }
    });

    on<UpdateMatiere>((event, emit) {
      // try {
      //   repository.updateFiliere(event.filiere);
      //   emit(FiliereOperationSuccess());
      // } catch (e) {
      //   emit(FiliereError(e.toString()));
      // }
    });

    on<DeleteDoc>((event, emit) {
      // try {
      //   repository.deleteFiliere(event.code);
      //   emit(FiliereOperationSuccess());
      // } catch (e) {
      //   emit(FiliereError(e.toString()));
      // }
    });
  }
}
