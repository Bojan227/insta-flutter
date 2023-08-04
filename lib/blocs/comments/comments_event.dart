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
