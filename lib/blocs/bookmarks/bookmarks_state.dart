part of 'bookmarks_bloc.dart';

class BookmarksState extends Equatable {
  final Status status;
  final List<Post> bookmarkedPosts;
  final String errorMessage;

  const BookmarksState(
      {required this.status,
      required this.bookmarkedPosts,
      required this.errorMessage});

  BookmarksState copyWith(
      {Status? status, List<Post>? bookmarkedPosts, String? errorMessage}) {
    return BookmarksState(
        status: status ?? this.status,
        bookmarkedPosts: bookmarkedPosts ?? this.bookmarkedPosts,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [status, bookmarkedPosts, errorMessage];
}
