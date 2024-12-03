import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/common/widgets/email_text_filed.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../common/auth/data/models/user_email_model.dart';
import '../bloc/niveaux/niveau_events.dart';
import '../bloc/niveaux/niveau_states.dart';

class EmailBottomSheet extends StatefulWidget {
  final UserRole role;
  final String code;

  const EmailBottomSheet({
    super.key,
    required this.role,
    required this.code,
  });

  @override
  EmailBottomSheetState createState() => EmailBottomSheetState();
}

class EmailBottomSheetState extends State<EmailBottomSheet> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: EmailTextField(controller: emailController),
          ),
          const SizedBox(width: 10.0),
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
                          role: widget.role,
                        ),
                        widget.code,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Icon(
                  EneftyIcons.arrow_right_bold,
                  size: 34.0,
                  color: Colors.blueAccent,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
