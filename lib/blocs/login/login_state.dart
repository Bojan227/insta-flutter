part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess({required this.login});

  final Login login;
}

class LoginFailed extends LoginState {
  const LoginFailed({required this.error});

  final String error;
}
