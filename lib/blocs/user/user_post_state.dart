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

class UserPostAdding extends UserPostsState {}

class UserPostAdded extends UserPostsState {
  const UserPostAdded({required this.userPost});

  final Post userPost;

  @override
  List<Object> get props => [userPost];
}

class UserPostFailed extends UserPostsState {
  const UserPostFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}

class UserPostSaving extends UserPostsState {}

class UserPostBookmarked extends UserPostsState {
  const UserPostBookmarked({required this.user, required this.post});

  final Post post;
  final User user;

  @override
  List<Object> get props => [post, user];
}

class UserPostBookmarkFailed extends UserPostsState {
  const UserPostBookmarkFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
