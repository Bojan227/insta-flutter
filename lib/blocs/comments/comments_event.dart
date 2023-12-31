part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class GetComments extends CommentsEvent {
  const GetComments({required this.postId});

  final String postId;

  @override
  List<Object> get props => [postId];
}

class AddComment extends CommentsEvent {
  const AddComment({required this.commentBody});

  final CommentBody commentBody;

  @override
  List<Object> get props => [commentBody];
}

class ToggleCommentLike extends CommentsEvent {
  const ToggleCommentLike({required this.commentId});

  final String commentId;

  @override
  List<Object> get props => [commentId];
}

class DeleteComment extends CommentsEvent {
  const DeleteComment({required this.commentId});

  final String commentId;

  @override
  List<Object> get props => [commentId];
}

class EditComment extends CommentsEvent {
  const EditComment({required this.commentId, required this.comment});

  final String commentId;
  final String comment;

  @override
  List<Object> get props => [commentId, comment];
}
