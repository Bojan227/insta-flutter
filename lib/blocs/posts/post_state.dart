part of '../posts/post_bloc.dart';

class PostState extends Equatable {
  const PostState({
    this.currentPage = 0,
    this.status = Status.initial,
    this.addPostStatus = Status.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final Status status;
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentPage;
  final Status addPostStatus;

  PostState copyWith(
      {Status? status,
      Status? addPostStatus,
      List<Post>? posts,
      bool? hasReachedMax,
      int? currentPage}) {
    return PostState(
      status: status ?? this.status,
      addPostStatus: addPostStatus ?? this.addPostStatus,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
