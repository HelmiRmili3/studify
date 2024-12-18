import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/filieres/professor_filieres_bloc.dart';
import '../blocs/filieres/professor_filieres_states.dart';
import 'filieres_loading_effect.dart';

class FilieresList extends StatefulWidget {
  // final Function(int) onItemTap;

  const FilieresList({
    super.key,
    // required this.onItemTap,
  });

  @override
  State<FilieresList> createState() => _ProfessorListState();
}

class _ProfessorListState extends State<FilieresList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessorFilieresBloc, ProfessorFilieresStates>(
        builder: (context, state) {
      if (state is FilieresLoading) {
        return const FilieresLoadingEffect();
      }
      if (state is FilieresError) {
        return Center(child: Text(state.message));
      }
      if (state is FilieresLoaded) {
        return SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.filieres.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 80.w,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.network(state.filieres[index].imageUrl,
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Flexible(
                        child: Text(
                          state.filieres[index].code.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12.sp,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w500,
                                  ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
