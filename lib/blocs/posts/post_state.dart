part of '../posts/post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  const PostLoaded({required this.posts});

  final List<Post> posts;
  @override
  List<Object> get props => [posts];
}

class PostFailed extends PostState {
  const PostFailed({required this.error});

  final String error;
  @override
  List<Object> get props => [error];
}
