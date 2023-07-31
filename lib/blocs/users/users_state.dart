part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  const UsersLoaded({required this.users});
  final List<User> users;

  @override
  List<Object> get props => [users];
}

class UsersFailed extends UsersState {
  const UsersFailed({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
