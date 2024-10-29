import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/blocs/theme/theme_bloc.dart';
import '../../../../../core/common/blocs/theme/theme_event.dart';
import '../../../../../core/common/blocs/theme/theme_state.dart';
import '../../../../etudiant/notification/presentation/widgets/custom_switch_row.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

class UserThemeMode extends StatelessWidget {
  const UserThemeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Theme Mode"),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Column(
            children: [
              CustomSwitchRow(
                title: 'Dark Mode',
                switchValue: state.isDarkTheme,
                onSwitchChanged: (value) {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
