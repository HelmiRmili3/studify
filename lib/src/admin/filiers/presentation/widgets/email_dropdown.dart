import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/utils/app_snack_bar.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/niveaux/niveau_events.dart';
import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../common/auth/data/models/user_data_model.dart';
import '../../../../../models/matiere.dart';
import '../bloc/niveaux/niveau_bloc.dart';

class EmailDropdown extends StatefulWidget {
  final List<UserDataModel> emailEntities;
  final Matiere matiere;
  final UserDataModel? initEmail;

  const EmailDropdown({
    super.key,
    required this.emailEntities,
    required this.matiere,
    this.initEmail,
  });

  @override
  State<EmailDropdown> createState() => _EmailDropdownState();
}

class _EmailDropdownState extends State<EmailDropdown> {
  UserDataModel? selectedEmail;

  @override
  void initState() {
    super.initState();
    // Set the initial email selection
    selectedEmail = widget.initEmail;
    debugPrint("Selected Email: ${selectedEmail?.id}");
    debugPrint(
        "Email Entities: ${widget.emailEntities.map((e) => e.id).toList()}");
  }

  void updateMatiere(BuildContext context) {
    if (selectedEmail == null) {
      AppSnackBar.showTopSnackBar(
        context,
        'Please select a professor.',
        Colors.yellow,
      );

      return;
    }

    if (widget.matiere.professor == selectedEmail!.id) {
      AppSnackBar.showTopSnackBar(
        context,
        'This professor is already assigned.',
        Colors.yellow,
      );
      return;
    }

    context.read<NiveauBloc>().add(UpdateMatiere(widget.matiere.copyWith(
          professor: selectedEmail!.id,
        )) as NiveauEvent);
    AppSnackBar.showTopSnackBar(
      context,
      'Professor updated successfully.',
      Colors.green,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dropdownItems = widget.emailEntities
        .map(
          (e) => DropdownMenuItem<UserDataModel>(
            value: e,
            child: Text("${e.firstName} ${e.lastName}"),
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<UserDataModel>(
          value: widget.emailEntities.contains(selectedEmail)
              ? selectedEmail
              : null,
          items: dropdownItems,
          onChanged: (value) {
            setState(() {
              selectedEmail = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Select Professor',
            filled: true,
            fillColor: Colors.blueAccent.withOpacity(0.1),
            hintStyle: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.lightBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 10.w,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        CustomElevatedButton(
          onPressed: () => updateMatiere(context),
          text: 'Update',
          icon: Icons.update,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
      ],
    );
  }
}
