import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.pettygramRepository, required this.storage})
      : super(UserPostsInitial()) {
    on<GetUserPosts>(_onGetUserPosts);
    on<AddPost>(_onAddPost);
    on<ToggleBookmark>(_onToggleBookmark);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> _onGetUserPosts(
      GetUserPosts event, Emitter<UserState> emit) async {
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

  Future<void> _onAddPost(AddPost event, Emitter<UserState> emit) async {
    emit(UserPostAdding());

    try {
      Post userPost = await pettygramRepository.addPost(event.userPost,
          Token(accessToken: storage.getString('accessToken')!));

      emit(
        UserPostAdded(userPost: userPost),
      );
    } on DioException catch (error) {
      emit(UserPostFailed(error: error.response?.data['error']));
    }
  }

  Future<void> _onToggleBookmark(
      ToggleBookmark event, Emitter<UserState> emit) async {
    emit(UserPostSaving());

    try {
      Map<String, dynamic> bookmarkResponse =
          await pettygramRepository.toggleBookmark(
        event.postId,
        Token(accessToken: storage.getString('accessToken')!),
      );

      emit(
        UserPostBookmarked(
          user: bookmarkResponse['user'],
          post: bookmarkResponse['post'],
        ),
      );
    } on DioException catch (error) {
      print(error.response);
      emit(UserPostBookmarkFailed(error: error.response?.data['error']));
    }
  }
}
