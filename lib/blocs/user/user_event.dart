part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserPosts extends UserEvent {
  const GetUserPosts({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}

class AddPost extends UserEvent {
  const AddPost({required this.userPost});

  final PostBody userPost;

  @override
  List<Object> get props => [userPost];
}

class ToggleBookmark extends UserEvent {
  const ToggleBookmark({required this.postId});

  final String postId;

  @override
  List<Object> get props => [postId];
}
