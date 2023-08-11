part of 'comment_cubit.dart';

enum CommentStatus { initial, loading, success, failure }

class CommentState extends Equatable {
  const CommentState({required this.commentStatus, required this.message});

  final CommentStatus commentStatus;
  final String message;

  @override
  List<Object> get props => [commentStatus, message];
}
