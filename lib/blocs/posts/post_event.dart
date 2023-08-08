part of '../posts/post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends PostEvent {}

class AddPost extends PostEvent {
  const AddPost({required this.userPost});

  final PostBody userPost;

  @override
  List<Object> get props => [userPost];
}
