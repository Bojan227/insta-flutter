part of '../posts/post_bloc.dart';

enum PostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  const PostState({
    this.currentPage = 0,
    this.status = PostStatus.initial,
    this.addPostStatus = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentPage;
  final PostStatus addPostStatus;

  PostState copyWith(
      {PostStatus? status,
      PostStatus? addPostStatus,
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
