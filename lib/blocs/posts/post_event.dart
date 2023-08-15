part of '../posts/post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends PostEvent {
  final int? page;

  const GetPosts({this.page});

  @override
  List<Object> get props => [page!];
}

class AddPost extends PostEvent {
  const AddPost({required this.userPost});

  final PostBody userPost;

  @override
  List<Object> get props => [userPost];
}

class ToggleLike extends PostEvent {
  const ToggleLike({required this.postId});

  final String postId;

  @override
  List<Object> get props => [postId];
}
