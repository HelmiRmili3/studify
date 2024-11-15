class Filiere {
  String filiere;
  String code;
  int nbYears;

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
