import 'dart:io';

import 'package:studify/models/new_filiere.dart';

abstract class FiliereEvent {}

class LoadFilieres extends FiliereEvent {}

class AddFiliere extends FiliereEvent {
  final NewFiliere filiere;
  final File? image;
  AddFiliere(
    this.filiere,
    this.image,
  );
}

class UpdateFiliere extends FiliereEvent {
  final NewFiliere filiere;
  UpdateFiliere(this.filiere);
}

class DeleteFiliere extends FiliereEvent {
  final String code;
  DeleteFiliere(this.code);
}
