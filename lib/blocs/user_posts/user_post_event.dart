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
