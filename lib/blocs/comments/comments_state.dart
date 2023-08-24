part of 'comments_bloc.dart';

class CommentsState extends Equatable {
  final List<Comment> comments;
  final Status status;
  final Status newCommentStatus;
  final Status editStatus;

  const CommentsState(
      {required this.comments,
      required this.status,
      required this.newCommentStatus,
      required this.editStatus});

  CommentsState copyWith(
      {Status? status,
      List<Comment>? comments,
      Status? newCommentStatus,
      Status? editStatus}) {
    return CommentsState(
      comments: comments ?? this.comments,
      status: status ?? this.status,
      newCommentStatus: newCommentStatus ?? this.newCommentStatus,
      editStatus: editStatus ?? this.editStatus,
    );
  }

  @override
  List<Object> get props => [comments, status, newCommentStatus, editStatus];
}
