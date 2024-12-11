class NewFiliere {
  String filiere;
  String code;
  int nbYears;
  String image;

  NewFiliere({
    required this.filiere,
    required this.code,
    required this.nbYears,
    required this.image,
  });

  // Convert Filiere to JSON
  Map<String, dynamic> toJson() {
    return {
      'filiere': filiere,
      'code': code,
      'nbYears': nbYears,
      'imageUrl': image,
    };
  }

  // Convert JSON to Filiere
  factory NewFiliere.fromJson(Map<String, dynamic> json) {
    return NewFiliere(
      filiere: json['filiere'],
      code: json['code'],
      nbYears: json['nbYears'],
      image: json['imageUrl'],
    );
  }

  // CopyWith Method
  NewFiliere copyWith({
    String? filiere,
    String? code,
    int? nbYears,
    String? image,
  }) {
    return NewFiliere(
      filiere: filiere ?? this.filiere,
      code: code ?? this.code,
      nbYears: nbYears ?? this.nbYears,
      image: image ?? this.image,
    );
  }
}
