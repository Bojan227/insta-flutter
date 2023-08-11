part of 'comments_bloc.dart';

enum CommentStatus { initial, loading, success, failure }

class CommentsState extends Equatable {
  final List<Comment> comments;
  final CommentStatus status;
  final CommentStatus newCommentStatus;

  const CommentsState({
    required this.comments,
    required this.status,
    required this.newCommentStatus,
  });

  CommentsState copyWith(
      {CommentStatus? status,
      List<Comment>? comments,
      CommentStatus? newCommentStatus,
      CommentStatus? updateState}) {
    return CommentsState(
      comments: comments ?? this.comments,
      status: status ?? this.status,
      newCommentStatus: newCommentStatus ?? this.newCommentStatus,
    );
  }

  @override
  List<Object> get props => [comments, status, newCommentStatus];
}
