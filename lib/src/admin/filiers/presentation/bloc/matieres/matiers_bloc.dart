import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/models/user.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/matieres/matiers_events.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/matieres/matiers_states.dart';

import '../../../data/repositories/matiere_repository.dart';

class MatiersBloc extends Bloc<MatiersEvent, MatiersState> {
  final MatiereRepository repository = MatiereRepository();
  MatiersBloc() : super(MatieresInitial()) {
    on<LoadMatieres>((event, emit) async {
      emit(MatieresLoading());
      try {
        await emit.forEach(repository.fetchMatieres(event.niveauId),
            onData: (matiers) => MatieresLoaded(matiers));
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
    on<UpdateMatiere>((event, emit) async {
      emit(MatieresLoading());
      try {
        Map<String, dynamic> result =
            await repository.updateMatiere(event.matiere).then((matiere) async {
          debugPrint("Matiere updated successfully");
          UserModel? user;
          if (matiere.professor != 'null') {
            user = await repository.getUserById(matiere.professor);
          }
          debugPrint("User id ===========>:  ${user!.uid}");

          return {"user": user, "matiere": matiere};
        });

        debugPrint("User id :  ${result['user'].uid}");
        MatiereUpdated(result['matiere'], result['user']);
      } catch (e) {
        emit(MatieresError(e.toString()));
        debugPrint("Error updating matiere: $e");
      }
    });
  }
}
