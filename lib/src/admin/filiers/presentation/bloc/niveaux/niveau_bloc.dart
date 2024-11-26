import 'package:bloc/bloc.dart';
import '../../../data/repositories/niveau_repository.dart';
import 'niveau_events.dart';
import 'niveau_states.dart';

class NiveauBloc extends Bloc<NiveauEvent, NiveauState> {
  final NiveauRepository repository = NiveauRepository();

  NiveauBloc() : super(NiveauInitial()) {
    on<LoadNiveau>((event, emit) async {
      emit(NiveauLoading());
      try {
        await emit.forEach(
          repository.streamNiveau(event.niveauId),
          onData: (niveau) => NiveauLoaded(niveau),
          onError: (error, stackTrace) => NiveauError(error.toString()),
        );
      } catch (e) {
        emit(NiveauError(e.toString()));
      }
    });

    on<AddEmail>((event, emit) async {
      emit(NiveauLoading());
      try {
        await repository.addEmail(
          event.email,
          event.niveauId,
        );
        emit(EmailAdded());
        add(LoadNiveau(event.niveauId));
      } catch (e) {
        emit(NiveauError(e.toString()));
      }
    });
  }
}
