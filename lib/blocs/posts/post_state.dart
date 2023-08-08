part of '../posts/post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  const PostState({
    this.currentPage = 0,
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentPage;

  PostState copyWith(
      {PostStatus? status,
      List<Post>? posts,
      bool? hasReachedMax,
      int? currentPage}) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  const PostLoaded({required this.posts});

  final List<Post> posts;
  @override
  List<Object> get props => [posts];
}

class PostFailed extends PostState {
  const PostFailed({required this.error});

  final String error;
  @override
  List<Object> get props => [error];
}

class UserPostAdding extends PostState {}

class UserPostAdded extends PostState {
  const UserPostAdded({required this.userPost});

  final Post userPost;

  @override
  List<Object> get props => [userPost];
}

class UserPostFailed extends PostState {
  const UserPostFailed({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
