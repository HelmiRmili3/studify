import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/common/widgets/fading_circle_loading_indicator.dart';
import 'package:studify/core/utils/helpers.dart';

import '../../../models/matiere.dart';
import '../../../src/common/auth/data/models/user_update_model.dart';
import '../../../src/common/auth/presentation/views/fill_your_profile_screen.dart';
import '../../utils/file_picker_helper.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../widgets/custom_elevated_button.dart';

import '../../../src/common/auth/presentation/widgets/custom_text_filed.dart';
import '../widgets/date_time_picker.dart';
import '../widgets/gender_selection.dart';

class StudentEditProfile extends StatefulWidget {
  const StudentEditProfile({super.key});

  @override
  State<StudentEditProfile> createState() => _StudentEditProfileState();
}

class _StudentEditProfileState extends State<StudentEditProfile> {
  final _formKey = GlobalKey<FormState>();
  FileEntity? _selectedImage;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: FadingCircleLoadingIndicator());
            }
            if (state is UserError) {
              return Center(
                  child: Text('Error loading user data: ${state.message}'));
            }
            if (state is UserLoaded) {
              final user = state.user;
              DateFormat dateFormat = DateFormat('yyyy-MM-dd');
              String formattedDate = dateFormat.format(user.birthDay);
              dateOfBirthController.text = formattedDate;
              fullNameController.text = user.firstName;
              nickNameController.text = user.lastName;
              phoneNumberController.text = user.phoneNumber;
              genderController.text = user.sexe.name.capitalizeFirst();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FileEntity? image =
                                  await FilePickerHelper.pickImage();
                              if (image != null) {
                                setState(() {
                                  _selectedImage = image;
                                });
                              }
                            },
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 140.h,
                                  height: 140.h,
                                  padding: EdgeInsets.all(4.h),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 3.w,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 60.h,
                                    backgroundColor: Colors.white,
                                    backgroundImage: _selectedImage != null
                                        ? FileImage(
                                            File(_selectedImage!.filepath))
                                        : NetworkImage(user.imageUrl),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.h,
                                  right: 5.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                      size: 20.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        hintText: 'Full Name',
                        controller: fullNameController,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        hintText: 'Nick Name',
                        controller: nickNameController,
                      ),
                      const SizedBox(height: 20.0),
                      DateTimeSelection(
                        controller: dateOfBirthController,
                        hintText: "Select your Birthday",
                        prefixIcon: Icons.date_range,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        prefixIcon: Icons.phone_android_outlined,
                        hintText: 'Phone Number',
                        controller: phoneNumberController,
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),
                      const SizedBox(height: 20.0),
                      GenderSelection(
                        options: const ["Male", "Female"],
                        controller: genderController,
                      ),
                      const SizedBox(height: 20.0),
                      CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            UserUpdateModel user = UserUpdateModel(
                              firstName: fullNameController.text,
                              lastName: nickNameController.text,
                              updatedAt: DateTime.now(),
                              phoneNumber: phoneNumberController.text,
                              sexe: stringToEnum(genderController.text.trim()),
                              birthDay: DateTime.tryParse(
                                  dateOfBirthController.text)!,
                              imageUrl: state.user.imageUrl,
                            );

                            context.read<UserBloc>().add(UpdateUser(
                                  user: user,
                                  newImage: _selectedImage,
                                ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please correct the errors in the form'),
                              ),
                            );
                          }
                        },
                        text: "Update",
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
