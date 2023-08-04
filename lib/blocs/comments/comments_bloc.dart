import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';

import '../../models/comment.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required this.pettygramRepository}) : super(CommentsInitial()) {
    on<GetComments>(_onGetComments);
  }

  final PettygramRepository pettygramRepository;

  Future<void> _onGetComments(
      GetComments event, Emitter<CommentsState> emit) async {
    emit(const CommentsLoading());

    try {
      final List<Comment> comments =
          await pettygramRepository.getCommentsByPostId(event.postId);

      emit(CommentsLoaded(comments: comments));
    } on DioException catch (error) {
      emit(CommentsFailed(error: error.response?.data['error']));
    }
  }
}
