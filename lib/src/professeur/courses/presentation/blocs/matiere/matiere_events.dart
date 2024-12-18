import 'package:file_picker/file_picker.dart';

import '../../../../../../core/utils/firestore_filter_model.dart';
import '../../../../../../models/filiere.dart';
import '../../../../../../models/matiere.dart';

abstract class MatiereEvents {}

class LoadDocs extends MatiereEvents {
  final List<FirestoreFilter> filters;

  LoadDocs({required this.filters});
}

class AddDoc extends MatiereEvents {
  final Doc doc;
  final List<PlatformFile> files;
  AddDoc(
    this.doc,
    this.files,
  );
}

class UpdateMatiere extends MatiereEvents {
  final Filiere matiere;
  UpdateMatiere(this.matiere);
}

class DeleteDoc extends MatiereEvents {}
