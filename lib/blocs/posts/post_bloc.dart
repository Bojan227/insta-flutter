import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.pettygramRepository, required this.storage})
      : super(PostInitial()) {
    on<GetPosts>(_onGetPosts);
    on<AddPost>(_onAddPost);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> _onGetPosts(GetPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());

    try {
      List<Post> userPosts = await pettygramRepository.getPosts(event.page);

      emit(
        PostLoaded(posts: userPosts),
      );
    } on DioException catch (error) {
      emit(PostFailed(error: error.response?.data['error']));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
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
}
