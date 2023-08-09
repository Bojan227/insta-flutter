part of '../posts/post_bloc.dart';

enum PostStatus { initial, success, failure }

enum AddPostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  const PostState({
    this.currentPage = 0,
    this.status = PostStatus.initial,
    this.addPostStatus = AddPostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentPage;
  final AddPostStatus addPostStatus;

  PostState copyWith(
      {PostStatus? status,
      AddPostStatus? addPostStatus,
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
