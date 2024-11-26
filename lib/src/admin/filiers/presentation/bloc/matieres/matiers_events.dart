import 'package:studify/models/matiere.dart';

abstract class MatiersEvent {}

class LoadMatieres extends MatiersEvent {
  final String niveauId;
  LoadMatieres(this.niveauId);
}

class AddMatiere extends MatiersEvent {
  final Matiere matiere;
  AddMatiere(this.matiere);
}
