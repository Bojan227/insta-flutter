part of 'user_post_bloc.dart';

abstract class UserPostsEvent extends Equatable {
  const UserPostsEvent();

  @override
  List<Object> get props => [];
}

class GetUserPosts extends UserPostsEvent {
  const GetUserPosts({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}

class AddPost extends UserPostsEvent {
  const AddPost({required this.userPost});

  final PostBody userPost;

  @override
  List<Object> get props => [userPost];
}

class ToggleBookmark extends UserPostsEvent {
  const ToggleBookmark({required this.postId});

  final String postId;

  @override
  List<Object> get props => [postId];
}
