import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/fading_circle_loading_indicator.dart';
import '../bloc/filieres/filiere_bloc.dart';
import '../bloc/filieres/filiere_events.dart';
import '../bloc/filieres/filiere_states.dart';
import 'add_new_filiere.dart';
import 'filieres_niveaux_list.dart';

class AdminFiliers extends StatefulWidget {
  const AdminFiliers({super.key});

  @override
  State<AdminFiliers> createState() => _AdminFiliersState();
}

class _AdminFiliersState extends State<AdminFiliers> {
  @override
  void initState() {
    super.initState();
    context.read<FiliereBloc>().add(LoadFilieres());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiliereBloc, FiliereState>(
      builder: (context, state) {
        if (state is FiliereLoading) {
          return const Center(
            child: FadingCircleLoadingIndicator(),
          );
        } else if (state is FiliereLoaded) {
          final filieres = state.filieres;
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
                              code: filieres[index].code,
                              name: filieres[index].filiere,
                              nbYears: filieres[index].nbYears,
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
                            filieres[index].code,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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
        } else if (state is FiliereError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}
