// theme_event.dart
import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {} // For switching themes

class LoadThemeEvent extends ThemeEvent {} // To load the stored theme
