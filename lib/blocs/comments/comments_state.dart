part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {
  const CommentsLoading();
}

class CommentsLoaded extends CommentsState {
  final List<Comment> comments;

  const CommentsLoaded({required this.comments});

  @override
  List<Object> get props => [comments];
}

class CommentsFailed extends CommentsState {
  final String error;

  const CommentsFailed({required this.error});

  @override
  List<Object> get props => [error];
}
