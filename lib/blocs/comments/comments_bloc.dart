import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/token.dart';

import '../../models/comment.dart';
import '../../models/comment_body.dart';
import '../../storage/shared_preferences.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required this.pettygramRepository, required this.storage})
      : super(
          const CommentsState(
            comments: [],
            status: CommentStatus.initial,
            newCommentStatus: CommentStatus.initial,
          ),
        ) {
    on<GetComments>(_onGetComments);
    on<AddComment>(_onAddComment);
    on<ToggleCommentLike>(_onToggleCommentLike);
    on<DeleteComment>(_onDeleteComment);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> _onGetComments(
      GetComments event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(
        status: CommentStatus.loading,
        newCommentStatus: CommentStatus.initial,
        updateState: CommentStatus.initial));

    try {
      final List<Comment> comments =
          await pettygramRepository.getCommentsByPostId(event.postId);

      emit(state.copyWith(status: CommentStatus.success, comments: comments));
    } on DioException catch (_) {
      emit(state.copyWith(status: CommentStatus.failure));
    }
  }

  FutureOr<void> _onAddComment(
      AddComment event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(newCommentStatus: CommentStatus.loading));

    try {
      final commentSuccessMessage = await pettygramRepository.addComment(
          event.commentBody,
          Token(accessToken: storage.getString('accessToken')!));

      emit(state.copyWith(
          newCommentStatus: CommentStatus.success,
          status: CommentStatus.initial));
    } on DioException catch (_) {
      emit(state.copyWith(newCommentStatus: CommentStatus.failure));
    }
  }

  Future<void> _onToggleCommentLike(
      ToggleCommentLike event, Emitter<CommentsState> emit) async {
    try {
      final comment = await pettygramRepository.toggleCommentLike(
          event.commentId,
          Token(accessToken: storage.getString('accessToken')!));

      final index = state.comments
          .indexWhere((commentObj) => commentObj.id == comment.id);
      state.comments[index] = comment;

      emit(state.copyWith(status: CommentStatus.initial));
      emit(state.copyWith(
          status: CommentStatus.success, comments: state.comments));
    } on DioException catch (_) {
      emit(state.copyWith(updateState: CommentStatus.failure));
    }
  }

  Future<void> _onDeleteComment(
      DeleteComment event, Emitter<CommentsState> emit) async {
    try {
      final successMessage = await pettygramRepository.deleteComment(
        event.commentId,
        Token(accessToken: storage.getString('accessToken')!),
      );

      final comments = state.comments
          .where((comment) => comment.id != event.commentId)
          .toList();

      emit(state.copyWith(status: CommentStatus.initial));
      emit(state.copyWith(status: CommentStatus.success, comments: comments));
    } on DioException catch (_) {
      emit(state.copyWith(updateState: CommentStatus.failure));
    }
  }
}
