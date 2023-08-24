import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/enums.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(currentMode: Mode.light));

  void toggleTheme() {
    emit(state.currentMode == Mode.light
        ? const ThemeState(currentMode: Mode.dark)
        : const ThemeState(currentMode: Mode.light));
  }
}
