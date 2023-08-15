part of 'theme_cubit.dart';

enum Mode { light, dark }

class ThemeState extends Equatable {
  const ThemeState({required this.currentMode});

  final Mode currentMode;

  @override
  List<Object> get props => [currentMode];
}
