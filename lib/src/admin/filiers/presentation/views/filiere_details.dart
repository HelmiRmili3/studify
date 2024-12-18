import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/common/widgets/fading_circle_loading_indicator.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_states.dart';
import '../bloc/niveaux/niveau_events.dart';
import '../widgets/costum_section_title.dart';
import '../widgets/email_bottom_cheet.dart';
import '../widgets/email_list.dart';
import '../widgets/matiere_bottom_sheet.dart';
import '../widgets/non_scrollable_daynamique_list.dart';
import 'matiere_details.dart';

class FiliereDetails extends StatefulWidget {
  final String code;
  const FiliereDetails({
    super.key,
    required this.code,
  });

  @override
  State<FiliereDetails> createState() => _FiliereDetailsState();
}

class _FiliereDetailsState extends State<FiliereDetails> {
  @override
  void initState() {
    context.read<NiveauBloc>().add(LoadNiveau(widget.code));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.code,
        action: [
          PopupMenuButton<String>(
            style: const ButtonStyle(),
            onSelected: (value) {
              if (value == 'Add new professor') {
                _showBottomSheet(
                    context,
                    EmailBottomSheet(
                      role: UserRole.professor,
                      code: widget.code,
                    ));
              } else if (value == 'Add new student') {
                _showBottomSheet(
                    context,
                    EmailBottomSheet(
                      role: UserRole.student,
                      code: widget.code,
                    ));
              } else {
                _showBottomSheet(
                    context,
                    MatiereBottomSheet(
                      code: widget.code,
                    ));
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'Add new professor',
                'Add new student',
                'Add new matiere',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<NiveauBloc, NiveauState>(
                builder: (context, state) {
                  if (state is NiveauLoading) {
                    return SizedBox(
                      height: 100.w,
                      child: const Center(
                        child: FadingCircleLoadingIndicator(),
                      ),
                    );
                  } else if (state is NiveauError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is NiveauLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildSectionTitle(
                          title: "Professors ",
                          number: state.professors.length,
                        ),
                        SizedBox(height: 20.h),
                        EmailList(
                          emails: state.professors,
                        ),
                        SizedBox(height: 20.h),
                        BuildSectionTitle(
                          title: "Students ",
                          number: state.students.length,
                        ),
                        SizedBox(height: 20.h),
                        EmailList(
                          emails: state.students,
                        ),
                        SizedBox(height: 20.h),
                        Column(
                          children: [
                            BuildSectionTitle(
                              title: "Matieres ",
                              number: state.matieres.length,
                            ),
                            SizedBox(height: 20.h),
                            NonScrollableDynamicList(
                              items: state.matieres,
                              itemBuilder: (matiere) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MatiereDetails(
                                          matiere: matiere,
                                          professorsEmails: state.professors,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 160.h,
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).splashColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            bottomLeft: Radius.circular(10.r),
                                          ),
                                          child: Container(
                                            width: 100.w,
                                            height: double.infinity,
                                            color: Colors.grey[300],
                                            child: Image.network(
                                              matiere.coverPhoto!.filepath,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '',
                                                      // '${professors.firstWhere((e) => e.id == matiere.professor).firstName.capitalizeFirst()} ${professors.firstWhere((e) => e.id == matiere.professor).lastName.capitalizeFirst()}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily:
                                                                'Mulish',
                                                            fontSize: 12.sp,
                                                            color: const Color(
                                                                0xFFFF6B00),
                                                          ),
                                                    ),
                                                    CircleAvatar(
                                                      radius: 16.r,
                                                      backgroundColor:
                                                          const Color(
                                                                  0xFFFF6B00)
                                                              .withOpacity(.5),
                                                      child: Text(
                                                          matiere.type.name
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge
                                                                  ?.copyWith(
                                                                    fontFamily:
                                                                        'Mulish',
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  matiere.name,
                                                  maxLines: 3,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontFamily: 'Jost',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.star,
                                                            color:
                                                                Colors.yellow,
                                                            size: 16.sp),
                                                        Text(
                                                          matiere.coefficient,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                    fontFamily:
                                                                        'Mulish',
                                                                    fontSize:
                                                                        11.sp,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    Container(
                                                      width: 2,
                                                      height: 16.h,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                      '${matiere.part.name.toUpperCase()} ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            fontFamily:
                                                                'Mulish',
                                                            fontSize: 14.sp,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return const Center(child: Text('Error found.'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => widget,
    );
  }
}
