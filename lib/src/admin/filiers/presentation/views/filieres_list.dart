import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_new_filiere.dart';
import 'filieres_niveaux_list.dart';

class AdminFiliers extends StatefulWidget {
  const AdminFiliers({super.key});

  @override
  State<AdminFiliers> createState() => _AdminFiliersState();
}

class _AdminFiliersState extends State<AdminFiliers> {
  List<dynamic> filieres = [
    {
      "filiere": "Licence  en Ingénierie des Systèmes Informatiques",
      "code": "LISI",
      "nbYears": 3,
    },
    {
      "filiere":
          "Licence en Technologies de l'information et des Télécommunications",
      "code": "LTIC",
      "nbYears": 3,
    },
    {
      "filiere": "Licence en Sciences de l’Informatique",
      "code": "LSIM",
      "nbYears": 3,
    },
    {
      "filiere": "Licence en  Art et Médiation",
      "code": "LAM",
      "nbYears": 3,
    },
    {
      "filiere": "Cycle Préparatoire Intégré",
      "code": "CPI",
      "nbYears": 2,
    },
    {
      "filiere": "Formation Ingénieur en Systèmes embarqués et IoT",
      "code": "FISE",
      "nbYears": 2,
    },
    {
      "filiere":
          "Formation Ingénieur en Génie logiciel et Systèmes d'Information",
      "code": "FIGL",
      "nbYears": 2,
    },
    {
      "filiere":
          "Mastère de Recherche En Sciences de l'Informatique et de Multimédia",
      "code": "MRSIM",
      "nbYears": 2,
    },
    {
      "filiere":
          "Mastère de Recherche en Electronique et Technologies de Communication Avancées",
      "code": "MRETCA",
      "nbYears": 2,
    },
    {
      "filiere": "Mastère Professionnel en Systèmes Embarqués & IoT",
      "code": "MPSEIOT",
      "nbYears": 2,
    },
    {
      "filiere": "Mastère Professionnel en Sécurité des Systèmes Informatique",
      "code": "MPSSI",
      "nbYears": 2,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: filieres.length + 1,
      itemBuilder: (context, index) {
        return index == filieres.length
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewFiliere(),
                    ),
                  );
                },
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Icon(Icons.add),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilieresNiveauxList(
                        code: filieres[index]["code"],
                        name: filieres[index]["filiere"],
                        nbYears: filieres[index]["nbYears"],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      '${filieres[index]["code"]}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Jost',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
