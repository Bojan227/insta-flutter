import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/token.dart';

import '../../injector/injector.dart';
import '../../models/comment.dart';
import '../../models/comment_body.dart';
import '../../storage/shared_preferences.dart';
import 'cubit/cubit/comment_cubit.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required this.pettygramRepository, required this.storage})
      : super(CommentsInitial()) {
    on<GetComments>(_onGetComments);
    on<AddComment>(_onAddComment);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> _onGetComments(
      GetComments event, Emitter<CommentsState> emit) async {
    emit(const CommentsLoading());

    final CommentCubit commentCubit = getIt<CommentCubit>();

    try {
      final List<Comment> comments =
          await pettygramRepository.getCommentsByPostId(event.postId);

      emit(CommentsLoaded(comments: comments));
      commentCubit.emit(const CommentState(
          commentStatus: CommentStatus.initial, message: 'initial'));
    } on DioException catch (error) {
      emit(CommentsFailed(error: error.response?.data['error']));
    }
  }

  FutureOr<void> _onAddComment(
      AddComment event, Emitter<CommentsState> emit) async {
    emit(const CommentAdding());

    try {
      final commentSuccessMessage = await pettygramRepository.addComment(
          event.commentBody,
          Token(accessToken: storage.getString('accessToken')!));

      emit(CommentAdded(commentMessage: commentSuccessMessage));
    } on DioException catch (error) {
      emit(CommentsFailed(error: error.response?.data['error']));
    }
  }
}
