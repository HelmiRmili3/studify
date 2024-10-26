// theme_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../themes.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(lightTheme)) {
    on<ToggleThemeEvent>((event, emit) {
      final isCurrentlyLight = state.themeData.brightness == Brightness.light;
      emit(
        ThemeState(
          isCurrentlyLight ? darkTheme : lightTheme,
        ),
      );
    });
  }
}
