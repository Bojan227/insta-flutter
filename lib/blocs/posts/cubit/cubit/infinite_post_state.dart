part of 'infinite_post_cubit.dart';

enum PostStatus { initial, success, failure }

class InfinitePostState extends Equatable {
  const InfinitePostState({
    this.currentPage = 0,
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentPage;

  InfinitePostState copyWith(
      {PostStatus? status,
      List<Post>? posts,
      bool? hasReachedMax,
      int? currentPage}) {
    return InfinitePostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
