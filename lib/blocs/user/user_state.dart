part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserPostsInitial extends UserState {}

class UserPostsLoading extends UserState {}

class UserPostsLoaded extends UserState {
  const UserPostsLoaded({required this.userPosts});

  final List<Post> userPosts;

  @override
  List<Object> get props => [userPosts];
}

class UserPostsFailed extends UserState {
  const UserPostsFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}

class UserPostSaving extends UserState {}

class UserPostBookmarked extends UserState {
  const UserPostBookmarked({required this.user, required this.post});

  final Post post;
  final User user;

  @override
  List<Object> get props => [post, user];
}

class UserPostBookmarkFailed extends UserState {
  const UserPostBookmarkFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
