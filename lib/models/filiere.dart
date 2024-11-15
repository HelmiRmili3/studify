import 'matiere.dart';
import 'professor.dart';
import 'student.dart';

class Filiere {
  String filiere;
  String code;
  String niveaux;
  List<Matiere> matieres;
  List<Student> students;
  List<Professor> professors;

  Filiere({
    required this.filiere,
    required this.code,
    required this.niveaux,
    this.matieres = const [],
    this.students = const [],
    this.professors = const [],
  });

  // Convert Filiere to JSON
  Map<String, dynamic> toJson() {
    return {
      'filiere': filiere,
      'code': code,
      'niveaux': niveaux,
      'matieres': matieres.map((matiere) => matiere.toJson()).toList(),
      'students': students.map((student) => student.toJson()).toList(),
      'professors': professors.map((professor) => professor.toJson()).toList(),
    };
  }

  // Convert JSON to Filiere
  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
      filiere: json['filiere'],
      code: json['code'],
      niveaux: json['niveaux'],
      matieres: (json['matieres'] as List<dynamic>)
          .map((matiere) => Matiere.fromJson(matiere))
          .toList(),
      students: (json['students'] as List<dynamic>)
          .map((student) => Student.fromJson(student))
          .toList(),
      professors: (json['professors'] as List<dynamic>)
          .map((professor) => Professor.fromJson(professor))
          .toList(),
    );
  }
}
