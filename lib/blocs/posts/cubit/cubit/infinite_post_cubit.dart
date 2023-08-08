import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/models/post.dart';

import '../../../../api/pettygram_repo_impl.dart';

part 'infinite_post_state.dart';

class InfinitePostCubit extends Cubit<InfinitePostState> {
  InfinitePostCubit({
    required this.pettygramRepository,
  }) : super(const InfinitePostState());

  final PettygramRepository pettygramRepository;

  Future<void> getPosts(String page) async {
    // check if its max number of posts
    if (state.hasReachedMax) return;

    if (state.status == PostStatus.initial) {
      List<Post> posts = await pettygramRepository.getPosts(page);

      emit(
        state.copyWith(
            status: PostStatus.success, posts: posts, hasReachedMax: false),
      );
    } else {
      List<Post> posts = await pettygramRepository.getPosts(page);

      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false));
    }
  }
}
