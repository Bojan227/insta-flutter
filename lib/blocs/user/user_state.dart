part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  const UsersLoaded({required this.users});
  final List<User> users;

  @override
  List<Object> get props => [users];
}

class UsersFailed extends UserState {
  const UsersFailed({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
