import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/models/matiere.dart';
import 'package:studify/src/admin/filiers/presentation/bloc/matieres/matiers_events.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../common/auth/data/models/user_data_model.dart';
import '../bloc/matieres/matiers_bloc.dart';
import '../bloc/matieres/matiers_states.dart';

class EmailDropdown extends StatefulWidget {
  final List<UserDataModel> emailEntities;
  final Matiere matiere;
  final UserDataModel? initEmail;

  const EmailDropdown({
    super.key,
    required this.emailEntities,
    required this.matiere,
    required this.initEmail,
  });

  @override
  State<EmailDropdown> createState() => _EmailDropdownState();
}

class _EmailDropdownState extends State<EmailDropdown> {
  UserDataModel? selectedEmail;

  @override
  void initState() {
    super.initState();
    selectedEmail = widget.initEmail;
  }

  void updateMatiere(BuildContext context) {
    if (selectedEmail == null) {
      debugPrint('No email selected.');
      Navigator.pop(context);
      return;
    }

    final emailEntity = widget.emailEntities.firstWhere(
      (e) => e.id == selectedEmail!.id,
      orElse: () => throw Exception('Selected email not found.'),
    );

    if (widget.matiere.professor == emailEntity.id) {
      debugPrint('Professor already selected: ${emailEntity.id}');
      Navigator.pop(context);
      return;
    }

    context.read<MatiersBloc>().add(UpdateMatiere(widget.matiere.copyWith(
          professor: emailEntity.id,
        )));
    debugPrint('Professor updated to: ${emailEntity.id}');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatiersBloc, MatiersState>(
      builder: (context, state) {
        if (state is MatieresLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomDropdownButtonFormField<UserDataModel>(
              value: selectedEmail,
              onChanged: (email) {
                setState(() {
                  selectedEmail = email;
                });
              },
              prefixIcon: Icons.email_outlined,
              items: widget.emailEntities,
              itemLabelBuilder: (email) => email.email,
            ),
            SizedBox(height: 10.h),
            CustomElevatedButton(
              onPressed: () => updateMatiere(context),
              text: 'Update',
              icon: Icons.update,
              backgroundColor: const Color(0xFFFF6B00),
              foregroundColor: Colors.white,
            ),
          ],
        );
      },
    );
  }
}

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final IconData? prefixIcon;
  final void Function(T?) onChanged;
  final String Function(T) itemLabelBuilder;

  const CustomDropdownButtonFormField({
    super.key,
    required this.value,
    required this.items,
    this.prefixIcon,
    required this.onChanged,
    required this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      style: TextStyle(
        fontFamily: 'Mulish',
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlack,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueAccent.withOpacity(.1),
        hintStyle: TextStyle(
          fontFamily: 'Mulish',
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.lightBlack,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.lightBlack,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
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
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            itemLabelBuilder(item),
            style: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.lightBlack,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
