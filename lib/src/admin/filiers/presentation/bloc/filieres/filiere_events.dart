import '../../../../../../models/filiere.dart';

abstract class FiliereEvent {}

class LoadFilieres extends FiliereEvent {}

class AddFiliere extends FiliereEvent {
  final Filiere filiere;
  AddFiliere(this.filiere);
}

class UpdateFiliere extends FiliereEvent {
  final Filiere filiere;
  UpdateFiliere(this.filiere);
}

class DeleteFiliere extends FiliereEvent {
  final String code;
  DeleteFiliere(this.code);
}
