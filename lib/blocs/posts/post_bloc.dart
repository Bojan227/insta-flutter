import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:stream_transform/stream_transform.dart';
part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.pettygramRepository, required this.storage})
      : super(const PostState()) {
    on<GetPosts>(_onGetPosts, transformer: throttleDroppable(throttleDuration));
    on<AddPost>(_onAddPost);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> _onGetPosts(GetPosts event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;

    try {
      print(event.page);

      if (event.page != null) {
        print('get posts');
        List<Post> posts = await pettygramRepository.getPosts(0);
        emit(
          state.copyWith(
              status: PostStatus.success,
              posts: posts,
              hasReachedMax: false,
              currentPage: 0),
        );

        return;
      } else if (state.status == PostStatus.initial) {
        List<Post> posts = await pettygramRepository.getPosts(0);

        emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      } else {
        List<Post> posts =
            await pettygramRepository.getPosts(state.currentPage);

        emit(
          posts.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : state.copyWith(
                  status: PostStatus.success,
                  posts: List.of(state.posts)..addAll(posts),
                  hasReachedMax: false,
                  currentPage: state.currentPage + 1),
        );
      }
    } on DioException catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(addPostStatus: PostStatus.loading));

    try {
      Post userPost = await pettygramRepository.addPost(event.userPost,
          Token(accessToken: storage.getString('accessToken')!));

      emit(state.copyWith(
          addPostStatus: PostStatus.success,
          posts: [userPost, ...state.posts]));
    } on DioException catch (_) {
      emit(state.copyWith(addPostStatus: PostStatus.failure));
    }
  }
}
