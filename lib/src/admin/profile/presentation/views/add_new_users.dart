import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/src/admin/profile/presentation/bloc/users/users_events.dart';
import 'package:studify/src/common/auth/presentation/widgets/custom_text_filed.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/common/widgets/fading_circle_loading_indicator.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../common/auth/data/models/user_email_model.dart';
import '../bloc/users/users_bloc.dart';
import '../bloc/users/users_states.dart';
import '../widgets/user_card.dart';

class AddNewUsers extends StatefulWidget {
  const AddNewUsers({super.key});

  @override
  State<AddNewUsers> createState() => _AddNewUsersState();
}

class _AddNewUsersState extends State<AddNewUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add New User',
        action: [
          Padding(
            padding: EdgeInsets.all(10.0.w),
            child: IconButton(
              onPressed: () {
                showAddEmailDialog(context, 'Add New Email', (email, role) {
                  String id = const Uuid().v1();
                  context.read<UsersBloc>().add(
                        AddUser(
                          UserEmailModel(
                            id: id,
                            email: '$email@isimg.tn',
                            role: role,
                          ),
                        ),
                      );
                });
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocListener<UsersBloc, UserState>(
            listener: (context, state) {
              if (state is UserOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}")),
                );
              }
            },
            child: BlocBuilder<UsersBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(
                    child: FadingCircleLoadingIndicator(),
                  );
                } else if (state is UserLoaded) {
                  final users = state.users;
                  if (users.isEmpty) {
                    return const Center(
                      child: Text("No users found."),
                    );
                  }
                  List<Widget> userCards = users.map((user) {
                    return UserCard(
                      user: user,
                      onDelete: () {
                        showConfirmationDialog(context, 'delete', () {
                          BlocProvider.of<UsersBloc>(context).add(
                            DeleteUser(user.id),
                          );
                        });
                      },
                    );
                  }).toList();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h),
                      ...userCards,
                      SizedBox(height: 10.h),
                    ],
                  );
                }
                return const Center(
                  child: Text("Please add a new user."),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

void showConfirmationDialog(
    BuildContext context, String text, Function onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm $text'),
        content: Text('Are you sure you want to $text this user?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm(); // Proceed with the action
            },
            child: Text(text),
          ),
        ],
      );
    },
  );
}

void showAddEmailDialog(BuildContext context, String text,
    void Function(String email, UserRole role) onConfirm) {
  final emailController = TextEditingController();
  UserRole selectedRole = UserRole.student;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        content: SizedBox(
          width: double.infinity,
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(hintText: 'Email', controller: emailController),
                SizedBox(height: 16.h),
                DropdownButtonFormField<UserRole>(
                  value: selectedRole,
                  onChanged: (UserRole? value) {
                    if (value != null) {
                      selectedRole = value;
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).splashColor,
                    hintText: 'Select Role',
                    hintStyle: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightBlack,
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
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
                  items: UserRole.values.map((UserRole role) {
                    return DropdownMenuItem<UserRole>(
                      value: role,
                      child: Text(
                        role.toString().split('.').last,
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightBlack,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm(emailController.text, selectedRole);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
