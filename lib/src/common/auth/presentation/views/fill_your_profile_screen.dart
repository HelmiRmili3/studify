import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/core/utils/file_picker_helper.dart';
import 'package:studify/models/matiere.dart';
import 'package:studify/src/common/auth/data/models/user_register_model.dart';
import 'package:studify/src/common/auth/presentation/widgets/custom_text_filed.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/routes/route_names.dart';
import '../blocs/register/register_bloc.dart';
import '../blocs/register/register_events.dart';
import '../blocs/register/register_states.dart';
import '../widgets/custom_avatar.dart';
import '../widgets/date_time_picker.dart';
import '../widgets/gender_selection.dart';

class FillYourProfileScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;
  const FillYourProfileScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<FillYourProfileScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<FillYourProfileScreen> {
  final formKey = GlobalKey<FormState>();
  FileEntity? _selectedImage;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  static void parseEmail(
      String email,
      TextEditingController firstNameController,
      TextEditingController lastNameController) {
    if (email.contains('@') && email.contains('.')) {
      String username = email.split('@')[0];

      List<String> names = username.split('.');
      if (names.length >= 2) {
        firstNameController.text = names[0];
        lastNameController.text = names[1];
      } else {
        firstNameController.text = names[0];
        lastNameController.text = '';
      }
    } else {
      firstNameController.text = '';
      lastNameController.text = '';
    }
  }

  @override
  void initState() {
    super.initState();
    parseEmail(
      widget.arguments['email'],
      firstNameController,
      lastNameController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Fill Your Profile'),
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RegisterFailure) {
            return Center(
              child: Text("Registration failed : ${state.error}"),
            );
          }
          if (state is RegisterSuccess) {
            context.pushReplacementNamed(RoutesNames.signin);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: formKey,
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
                            _selectedImage = await FilePickerHelper.pickImage();
                            setState(() {});
                          },
                          child: UserProfileAvatar(
                            imagepath: _selectedImage != null
                                ? _selectedImage!.filepath
                                : '',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      hintText: 'First Name',
                      controller: firstNameController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      hintText: 'Last Name',
                      controller: lastNameController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      prefixIcon: Icons.phone_android_outlined,
                      keyboardType: TextInputType.phone,
                      hintText: 'Phone Number',
                      controller: phoneNumberController,
                    ),
                    const SizedBox(height: 20.0),
                    DateTimeSelection(
                      controller: dateOfBirthController,
                      hintText: "Select your Birthday",
                      prefixIcon: Icons.date_range,
                    ),
                    const SizedBox(height: 20.0),
                    GenderSelection(
                      options: const ["Male", "Female"],
                      controller: genderController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomElevatedButton(
                      onPressed: () {
                        // if (formKey.currentState!.validate()) {
                        context.read<RegisterBloc>().add(
                              RegisterRequested(
                                UserRegisterModel(
                                  uid: const Uuid().v1(),
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  birthDay: DateTime.parse(
                                      dateOfBirthController.text),
                                  email: widget.arguments['email'],
                                  phoneNumber: phoneNumberController.text,
                                  sexe: stringToEnum(
                                      genderController.text.trim()),
                                  createdAt: DateTime.now(),
                                  password: widget.arguments['password'],
                                  updatedAt: DateTime.now(),
                                  image: _selectedImage,
                                ),
                              ),
                            );
                        // }
                      },
                      text: "Continue",
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

UserGender stringToEnum(String value) {
  switch (value.toLowerCase()) {
    case "male":
      return UserGender.male;
    case "female":
      return UserGender.female;
    default:
      return UserGender.unknown;
  }
}
