class Filiere {
  final String filiere;
  final String code;
  final int nbYears;

  Filiere({
    required this.filiere,
    required this.code,
    required this.nbYears,
  });

  // Convert Filiere to JSON
  Map<String, dynamic> toJson() {
    return {
      'filiere': filiere,
      'code': code,
      'nbYears': nbYears,
    };
  }

  // Convert JSON to Filiere
  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
      filiere: json['filiere'],
      code: json['code'],
      nbYears: json['nbYears'],
    );
  }
}

class Niveau extends Filiere {
  final List<String> studentIds;
  final int niveau;

  Niveau({
    required super.filiere,
    required super.code,
    required super.nbYears,
    required this.niveau,
    required this.studentIds,
  });

  // Convert Niveau to JSON
  @override
  Map<String, dynamic> toJson() {
    final filiereJson = super.toJson();
    return {
      ...filiereJson,
      'studentIds': studentIds,
      'niveaux': niveau,
    };
  }

  // Convert JSON to Niveau
  factory Niveau.fromJson(Map<String, dynamic> json) {
    return Niveau(
      filiere: json['filiere'],
      code: json['code'],
      niveau: json['niveau'],
      nbYears: json['nbYears'],
      studentIds: List<String>.from(json['studentIds'] ?? []),
    );
  }
}

class Part extends Niveau {
  final List<String> professorsIds;
  final List<String> matieresIds;

  Part({
    required String filiere,
    required String code,
    required int niveau,
    required int nbYears,
    required List<String> studentIds,
    required this.professorsIds,
    required this.matieresIds,
  }) : super(
          filiere: filiere,
          code: code,
          niveau: niveau,
          nbYears: nbYears,
          studentIds: studentIds,
        );

  // Convert Part to JSON
  @override
  Map<String, dynamic> toJson() {
    final niveauJson = super.toJson();
    return {
      ...niveauJson,
      'professorsIds': professorsIds,
      'matieresIds': matieresIds,
    };
  }

  // Convert JSON to Part
  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      filiere: json['filiere'],
      code: json['code'],
      niveau: json['niveau'],
      nbYears: json['nbYears'],
      studentIds: List<String>.from(json['studentIds'] ?? []),
      professorsIds: List<String>.from(json['professorsIds'] ?? []),
      matieresIds: List<String>.from(json['matieresIds'] ?? []),
    );
  }
}
