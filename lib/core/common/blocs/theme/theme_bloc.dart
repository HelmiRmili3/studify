import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/themes.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = "themeValue";

  ThemeBloc()
      : super(ThemeState(
          themeData: lightTheme,
          isDarkTheme: false,
        )) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  Future<void> _onLoadTheme(
      LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool(_themeKey) ?? false;
    emit(ThemeState(
      themeData: isDarkTheme ? darkTheme : lightTheme,
      isDarkTheme: isDarkTheme,
    ));
  }

  Future<void> _onToggleTheme(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final newTheme = !state.isDarkTheme;
    final newThemeData = newTheme ? darkTheme : lightTheme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, newTheme);

    emit(ThemeState(
      themeData: newThemeData,
      isDarkTheme: newTheme,
    ));
  }
}
