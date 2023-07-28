import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.pettygramRepository}) : super(PostInitial()) {
    on<GetPosts>(_onGetPosts);
  }

  final PettygramRepository pettygramRepository;

  Future<void> _onGetPosts(GetPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());

    try {
      List<Post> userPosts = await pettygramRepository.getPosts();

      emit(
        PostLoaded(posts: userPosts),
      );
    } on DioException catch (error) {
      emit(PostFailed(error: error.response?.data['error']));
    }
  }
}
