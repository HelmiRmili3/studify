import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../../models/user.dart';
import '../../../data/repositories/matiere_repository.dart';
import '../../../data/repositories/niveau_repository.dart';
import 'niveau_events.dart';
import 'niveau_states.dart';

class NiveauBloc extends Bloc<NiveauEvent, NiveauState> {
  final NiveauRepository repository = NiveauRepository();
  final MatiereRepository matiereRepository = MatiereRepository();

  NiveauBloc() : super(NiveauInitial()) {
    on<LoadNiveau>((event, emit) async {
      emit(NiveauLoading());
      try {
        await emit.forEach(
          repository.streamNiveau(event.niveauId),
          onData: (data) => NiveauLoaded(
            (data["students"]),
            (data["professors"]),
            data["matieres"] ?? [],
          ),
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

    on<AddMatiere>((event, emit) async {
      emit(NiveauLoading());
      try {
        await matiereRepository.addMatiere(event.matiere);
        MatiereAdded();
      } catch (e) {
        emit(NiveauError(e.toString()));
      }
    });

    on<UpdateMatiere>((event, emit) async {
      emit(NiveauLoading());
      try {
        Map<String, dynamic> result = await matiereRepository
            .updateMatiere(event.matiere)
            .then((matiere) async {
          debugPrint("Matiere updated successfully");
          UserModel? user;
          if (matiere.professor != 'null') {
            user = await matiereRepository.getUserById(matiere.professor);
          }
          debugPrint("User id ===========>:  ${user!.uid}");
          return {"user": user, "matiere": matiere};
        });

        debugPrint("User id :  ${result['user'].uid}");
        MatiereUpdated(result['matiere'], result['user']);
        add(LoadNiveau(event.matiere.filiere));
      } catch (e) {
        emit(NiveauError(e.toString()));
        debugPrint("Error updating matiere: $e");
      }
    });
  }
}
