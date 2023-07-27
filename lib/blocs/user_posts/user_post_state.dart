part of 'user_post_bloc.dart';

abstract class UserPostsState extends Equatable {
  const UserPostsState();

  @override
  List<Object> get props => [];
}

class UserPostsInitial extends UserPostsState {}

class UserPostsLoading extends UserPostsState {}

class UserPostsLoaded extends UserPostsState {
  const UserPostsLoaded({required this.userPosts});

  final List<Post> userPosts;

  @override
  List<Object> get props => [userPosts];
}

class UserPostsFailed extends UserPostsState {
  const UserPostsFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
