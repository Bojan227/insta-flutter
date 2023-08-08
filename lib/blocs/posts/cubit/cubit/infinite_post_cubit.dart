import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../api/pettygram_repo_impl.dart';

part 'infinite_post_state.dart';

class InfinitePostCubit extends Cubit<InfinitePostState> {
  InfinitePostCubit({
    required this.pettygramRepository,
  }) : super(const InfinitePostState());

  final PettygramRepository pettygramRepository;

  Future<void> getPosts() async {
    // check if its max number of posts
    if (state.hasReachedMax) return;

    if (state.status == PostStatus.initial) {
      List<Post> posts = await pettygramRepository.getPosts(0);

      emit(
        state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
            currentPage: state.currentPage + 1),
      );
    } else {
      print(state.currentPage);
      List<Post> posts = await pettygramRepository.getPosts(state.currentPage);

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
  }
}
