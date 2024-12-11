import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:uuid/uuid.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/file_picker_helper.dart';
import '../../../../../models/matiere.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';
import '../bloc/matieres/matiers_bloc.dart';
import '../bloc/matieres/matiers_events.dart';
import '../bloc/matieres/matiers_states.dart';
import 'costum_section_title.dart';
import 'cover_photo_selector.dart';
import 'custom_dropdown_form_filed.dart';

class MatiereBottomSheet extends StatefulWidget {
  final String code;

  const MatiereBottomSheet({
    super.key,
    required this.code,
  });

  @override
  MatiereBottomSheetState createState() => MatiereBottomSheetState();
}

class MatiereBottomSheetState extends State<MatiereBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController coefficientController = TextEditingController();

  MatiereType selectedType = MatiereType.co;
  MatierePart selectedPart = MatierePart.p1;
  FileEntity? _selectedImage;
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    coefficientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 5.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            const BuildSectionTitle(
              title: "Add New Matiere",
              number: null,
            ),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () async {
                  _selectedImage = await FilePickerHelper.pickImage();
                  setState(() {});
                },
                child: CoverPhotoSelector(
                  imagePath:
                      _selectedImage != null ? _selectedImage!.filepath : '',
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(controller: nameController, hintText: 'Name'),
            const SizedBox(height: 10),
            CustomTextField(
                controller: descriptionController, hintText: 'Description'),
            const SizedBox(height: 10),
            CustomTextField(
                controller: coefficientController, hintText: 'Coefficient'),
            const SizedBox(height: 10),
            CustomDropdownButtonFormField<MatierePart>(
              value: selectedPart,
              onChanged: (part) {
                if (part != null) setState(() => selectedPart = part);
              },
              hintText: "Select a part",
              prefixIcon: Icons.category_outlined,
              items: MatierePart.values,
              itemLabelBuilder: (type) => type.toString().split('.').last,
            ),
            const SizedBox(height: 10),
            CustomDropdownButtonFormField<MatiereType>(
              value: selectedType,
              onChanged: (type) {
                if (type != null) setState(() => selectedType = type);
              },
              hintText: "Select a type",
              prefixIcon: Icons.category_outlined,
              items: MatiereType.values,
              itemLabelBuilder: (type) => type.toString().split('.').last,
            ),
            const SizedBox(height: 10),
            BlocBuilder<MatiersBloc, MatiersState>(
              builder: (context, state) {
                if (state is MatieresLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 60.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).splashColor),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 20.w),
                          ),
                          foregroundColor:
                              WidgetStateProperty.all(AppColors.lightBlack),
                          textStyle: WidgetStateProperty.all(
                            TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      SizedBox(width: 10.w),
                      // Add Matiere Button
                      ElevatedButton(
                        onPressed: () {
                          final String id = const Uuid().v1();
                          final String name = nameController.text.trim();
                          final String description =
                              descriptionController.text.trim();
                          final String coefficient =
                              coefficientController.text.trim();
                          if (name.isNotEmpty &&
                              description.isNotEmpty &&
                              coefficient.isNotEmpty) {
                            final newMatiere = Matiere(
                              id: id,
                              name: name,
                              professor: 'null',
                              raitings: [],
                              favorites: [],
                              filiere: widget.code,
                              description: description,
                              part: selectedPart,
                              coefficient: coefficient,
                              type: selectedType,
                              coverPhoto: _selectedImage,
                            );
                            BlocProvider.of<MatiersBloc>(context).add(
                              AddMatiere(newMatiere),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.lightPrimary),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(
                              vertical: 15.h,
                              horizontal: 20.w,
                            ),
                          ),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                          textStyle: WidgetStateProperty.all(
                            TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        child: const Text('Add Matiere'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
