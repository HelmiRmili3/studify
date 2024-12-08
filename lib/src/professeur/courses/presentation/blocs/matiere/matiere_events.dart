import '../../../../../../models/filiere.dart';
import '../../../../../../models/matiere.dart';

abstract class MatiereEvents {}

class LoadDocs extends MatiereEvents {}

class AddDoc extends MatiereEvents {
  final Matiere matiere;
  AddDoc(this.matiere);
}

class UpdateMatiere extends MatiereEvents {
  final Filiere matiere;
  UpdateMatiere(this.matiere);
}

class DeleteDoc extends MatiereEvents {}
