part of 'user_cubit.dart';

abstract class UserStateCubit extends Equatable {
  const UserStateCubit();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserStateCubit {}

class UserLoading extends UserStateCubit {}

class UserLoaded extends UserStateCubit {
  const UserLoaded({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class UserFailed extends UserStateCubit {}

class UserEditInProgress extends UserStateCubit {}

class UserEditSuccess extends UserStateCubit {
  const UserEditSuccess({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class UserEditFailed extends UserStateCubit {
  const UserEditFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}

class UserPictureUpdateInProgress extends UserStateCubit {}

class UserPictureUpdateSuccess extends UserStateCubit {
  const UserPictureUpdateSuccess({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class UserPictureUpdateFailed extends UserStateCubit {
  const UserPictureUpdateFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
