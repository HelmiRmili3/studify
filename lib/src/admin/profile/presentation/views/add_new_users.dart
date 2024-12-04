import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_elevated_button.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/src/admin/profile/presentation/bloc/users/users_events.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
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
      appBar: const CustomAppBar(
        title: 'Add New User',
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
                    child: CircularProgressIndicator(),
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
                      CustomElevatedButton(
                        onPressed: () {
                          showConfirmationDialog(context, 'add', () {
                            String id = const Uuid().v1();
                            String email =
                                'example.${id[0]}${id[3]}am${id[5]}le@isimg.tn';
                            context.read<UsersBloc>().add(
                                  AddUser(
                                    UserEmailModel(
                                      id: id,
                                      email: email,
                                      role: UserRole.student,
                                    ),
                                  ),
                                );
                          });
                        },
                        text: "Add New User",
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      SizedBox(height: 16.h),
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
              onConfirm(); // Proceed with deletion
            },
            child: Text(text),
          ),
        ],
      );
    },
  );
}
