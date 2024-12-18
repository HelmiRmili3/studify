import '../../../../../../models/matiere.dart';
import '../../../../../../models/professor.dart';
import '../../../../../common/auth/data/models/user_email_model.dart';

abstract class NiveauEvent {}

class LoadNiveau extends NiveauEvent {
  final String niveauId;
  LoadNiveau(this.niveauId);
}

class AddEmail extends NiveauEvent {
  final UserEmailModel email;
  final String niveauId;
  AddEmail(this.email, this.niveauId);
}

class AddProfessor extends NiveauEvent {
  final Professor professor;
  AddProfessor(this.professor);
}

class AddMatiere extends NiveauEvent {
  final Matiere matiere;
  AddMatiere(this.matiere);
}

class UpdateMatiere extends NiveauEvent {
  final Matiere matiere;
  UpdateMatiere(this.matiere);
}

// class AddSubject extends NiveauEvent {
//     final Subject subject;
//     AddSubject(this.subject);
// }
