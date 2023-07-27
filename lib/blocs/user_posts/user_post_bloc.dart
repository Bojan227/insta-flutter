import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/post.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostsEvent, UserPostsState> {
  UserPostBloc({required this.pettygramRepository})
      : super(UserPostsInitial()) {
    on<GetUserPosts>(_onGetUserPosts);
  }

  final PettygramRepository pettygramRepository;

  Future<void> _onGetUserPosts(
      GetUserPosts event, Emitter<UserPostsState> emit) async {
    emit(UserPostsLoading());

    try {
      List<Post> userPosts =
          await pettygramRepository.getPostsByUserId(event.userId);

      emit(
        UserPostsLoaded(userPosts: userPosts),
      );
    } on DioException catch (error) {
      emit(UserPostsFailed(error: error.response?.data['error']));
    }
  }
}
