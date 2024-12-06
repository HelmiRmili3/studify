import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_states.dart';
import 'package:studify/src/admin/filiers/presentation/widgets/course_loading.dart';

import '../../../../common/auth/data/models/user_data_model.dart';
import '../bloc/matieres/matiers_bloc.dart';
import '../bloc/matieres/matiers_events.dart';
import '../bloc/matieres/matiers_states.dart';
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
  final TextEditingController filiereName = TextEditingController();
  late List<UserDataModel> professorsEmails;
  @override
  void initState() {
    super.initState();
    context.read<NiveauBloc>().add(LoadNiveau(widget.code));
    context.read<MatiersBloc>().add(LoadMatieres(widget.code));
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
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is NiveauError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is NiveauLoaded) {
                    final List<UserDataModel> emails = state.niveau;
                    debugPrint(
                      'emails: ${emails.length}',
                    );

                    professorsEmails = emails
                        .where((email) => email.role == UserRole.professor)
                        .toList()
                      ..add(UserDataModel(
                        id: "null",
                        email: "",
                        role: UserRole.professor,
                        firstName: '',
                        lastName: '',
                      ));
                    final List<UserDataModel> professors = emails
                        .where((email) => email.role == UserRole.professor)
                        .toList();

                    final List<UserDataModel> students = emails
                        .where((email) => email.role == UserRole.student)
                        .toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildSectionTitle(
                          title: "Professors ",
                          number: professors.length,
                        ),
                        SizedBox(height: 20.h),
                        EmailList(
                          emails: professors,
                        ),
                        SizedBox(height: 20.h),
                        BuildSectionTitle(
                          title: "Students ",
                          number: students.length,
                        ),
                        SizedBox(height: 20.h),
                        EmailList(
                          emails: students,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  } else {
                    return const Center(child: Text('Error found.'));
                  }
                },
              ),
              BlocBuilder<MatiersBloc, MatiersState>(
                builder: (context, state) {
                  if (state is MatieresLoading) {
                    return const CoursesLoading(
                      count: 5,
                    );
                  }
                  if (state is MatieresLoaded) {
                    final matieres = state.matiers;
                    return Column(
                      children: [
                        BuildSectionTitle(
                          title: "Matieres ",
                          number: matieres.length,
                        ),
                        SizedBox(height: 20.h),
                        NonScrollableDynamicList(
                          items: matieres,
                          itemBuilder: (matiere) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MatiereDetails(
                                      matiere: matiere,
                                      professorsEmails: professorsEmails,
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
                                                  "Teacher",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        fontFamily: 'Mulish',
                                                        fontSize: 12.sp,
                                                        color: const Color(
                                                            0xFFFF6B00),
                                                      ),
                                                ),
                                                CircleAvatar(
                                                  radius: 16.r,
                                                  backgroundColor:
                                                      const Color(0xFFFF6B00)
                                                          .withOpacity(.5),
                                                  child: Text(
                                                      matiere.type.name
                                                          .toUpperCase(),
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily:
                                                                'Mulish',
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.yellow,
                                                        size: 16.sp),
                                                    Text(
                                                      matiere.coefficient,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            fontFamily:
                                                                'Mulish',
                                                            fontSize: 11.sp,
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
                                                        fontFamily: 'Mulish',
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
                    );
                  }
                  if (state is MatieresError) {
                    return Center(
                      child: Text("error : ${state.error}"),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
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
