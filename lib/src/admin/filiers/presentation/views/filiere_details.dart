import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_states.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/matiere.dart';
import '../../../../common/auth/data/models/user_email_model.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';
import '../../../../etudiant/notification/presentation/widgets/notifications_list.dart';
import '../bloc/matieres/matiers_bloc.dart';
import '../bloc/matieres/matiers_events.dart';
import '../bloc/matieres/matiers_states.dart';
import '../bloc/niveaux/niveau_events.dart';
import '../widgets/email_list.dart';
import '../../../../../core/common/widgets/email_text_filed.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<NiveauBloc>().add(LoadNiveau(widget.code));
    context.read<MatiersBloc>().add(LoadMatieres(widget.code));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.code),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            children: [
              BlocBuilder<NiveauBloc, NiveauState>(
                builder: (context, state) {
                  if (state is NiveauLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NiveauError) {
                    return Center(
                      child: Text('Error: ${state.error}'),
                    );
                  } else if (state is NiveauLoaded) {
                    final List<UserEmailModel> emails = state.niveau;
                    debugPrint(
                      'emails: ${emails.length}',
                    );

                    final List<String> professors = emails
                        .where((email) => email.role == UserRole.professor)
                        .map((email) => email.email)
                        .toList();

                    final List<String> students = emails
                        .where((email) => email.role == UserRole.student)
                        .map((email) => email.email)
                        .toList();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(context, "Professors"),
                        SizedBox(height: 20.h),
                        EmailList(
                          emails: professors,
                          onTap: () => _showBottomEmailSheet(
                            context,
                            UserRole.professor,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildSectionTitle(context, "Students"),
                        SizedBox(height: 20.h),
                        EmailList(
                          emails: students,
                          onTap: () => _showBottomEmailSheet(
                            context,
                            UserRole.student,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildSectionTitle(context, "Matieres"),
                        SizedBox(height: 20.h),
                      ],
                    );
                  } else if (state is EmailAdded) {
                    return const Center(
                        child: Text('Email Added Successfully.'));
                  } else {
                    return const Center(child: Text('Error found.'));
                  }
                },
              ),
              BlocBuilder<MatiersBloc, MatiersState>(
                builder: (context, state) {
                  if (state is MatieresLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is MatieresLoaded) {
                    final matieres = state.matiers;

                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: matieres.length,
                          itemBuilder: (context, index) {
                            final matiere = matieres[index];
                            return NotificationCard(
                              notification: NotificationItem(
                                title: matiere.name,
                                subtitle: '${matiere.part} parts',
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => _showBottomMatiereSheet(context),
                            child: const Text('Click Me'),
                          ),
                        )
                      ],
                    );
                  }
                  if (state is MatieresError) {
                    return Center(
                      child: Text("error : ${state.error}"),
                    );
                  }
                  return Center(
                    child: ElevatedButton(
                      onPressed: () => _showBottomMatiereSheet(context),
                      child: const Text('Click Me'),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: 'Jost',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  void _showBottomEmailSheet(BuildContext context, UserRole role) {
    final TextEditingController emailController = TextEditingController();
    debugPrint('role: $role');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: EmailTextField(controller: emailController),
              ),
              SizedBox(width: 10.w),
              BlocBuilder<NiveauBloc, NiveauState>(
                builder: (context, state) {
                  if (state is NiveauLoading) {
                    return const CircularProgressIndicator();
                  }
                  return GestureDetector(
                    onTap: () {
                      final String emailText = emailController.text.trim();
                      if (emailText.isNotEmpty) {
                        BlocProvider.of<NiveauBloc>(context).add(
                          AddEmail(
                            UserEmailModel(
                              id: const Uuid().v1(),
                              email: '$emailText@isimg.tn',
                              role: role,
                            ),
                            widget.code,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(
                      EneftyIcons.arrow_right_bold,
                      size: 34.sp,
                      color: Colors.blueAccent,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomMatiereSheet(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController partController = TextEditingController();
    final TextEditingController coefficientController = TextEditingController();
    MatiereType selectedType = MatiereType.Cours;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Matiere',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: nameController,
                hintText: 'Name',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: partController,
                hintText: 'Part',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: coefficientController,
                hintText: 'Coefficient',
              ),
              const SizedBox(height: 10),
              DropdownButton<MatiereType>(
                value: selectedType,
                onChanged: (MatiereType? newValue) {
                  if (newValue != null) {
                    selectedType = newValue;
                  }
                },
                items: MatiereType.values.map((type) {
                  return DropdownMenuItem<MatiereType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              BlocBuilder<MatiersBloc, MatiersState>(
                builder: (context, state) {
                  if (state is MatieresLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final String id = const Uuid().v1();
                          final String name = nameController.text.trim();
                          final String description =
                              descriptionController.text.trim();
                          final int part =
                              int.tryParse(partController.text) ?? 0;
                          final String coefficient =
                              coefficientController.text.trim();

                          if (name.isNotEmpty &&
                              description.isNotEmpty &&
                              coefficient.isNotEmpty) {
                            final newMatiere = Matiere(
                              id: id,
                              name: name,
                              filiere: widget.code,
                              description: description,
                              part: part,
                              coefficient: coefficient,
                              type: selectedType,
                            );

                            BlocProvider.of<MatiersBloc>(context).add(
                              AddMatiere(newMatiere),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Add Matiere'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
