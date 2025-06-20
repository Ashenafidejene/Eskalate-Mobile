import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(_buildLightTheme())) {
    on<ToggleThemeEvent>((event, emit) {
      emit(
        ThemeState(
          state.themeData.brightness == Brightness.dark
              ? _buildLightTheme()
              : _buildDarkTheme(),
        ),
      );
    });
  }

  static ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
