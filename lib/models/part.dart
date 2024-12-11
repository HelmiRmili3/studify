import 'dart:io';

class Filiere {
  final String filiere;
  final String code;
  final int nbYears;
  final File image;

  Filiere({
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
  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
      filiere: json['filiere'],
      code: json['code'],
      nbYears: json['nbYears'],
      image: json['image'],
    );
  }
}
