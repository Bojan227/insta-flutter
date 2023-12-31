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
import '../../utils/enums.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required this.pettygramRepository, required this.storage})
      : super(
          const CommentsState(
              comments: [],
              status: Status.initial,
              newCommentStatus: Status.initial,
              editStatus: Status.initial),
        ) {
    on<GetComments>(_onGetComments);
    on<AddComment>(_onAddComment);
    on<EditComment>(_onEditComment);
    on<ToggleCommentLike>(_onToggleCommentLike);
    on<DeleteComment>(_onDeleteComment);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> _onGetComments(
      GetComments event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(
        status: Status.loading,
        newCommentStatus: Status.initial,
        editStatus: Status.initial));

    try {
      final List<Comment> comments =
          await pettygramRepository.getCommentsByPostId(event.postId);

      emit(state.copyWith(status: Status.success, comments: comments));
    } on DioException catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  FutureOr<void> _onAddComment(
      AddComment event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(newCommentStatus: Status.loading));

    try {
      final commentSuccessMessage = await pettygramRepository.addComment(
          event.commentBody,
          Token(accessToken: storage.getString('accessToken')!));

      emit(state.copyWith(
          newCommentStatus: Status.success, status: Status.initial));
    } on DioException catch (_) {
      emit(state.copyWith(newCommentStatus: Status.failure));
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

      emit(state.copyWith(status: Status.initial));
      emit(state.copyWith(status: Status.success, comments: state.comments));
    } on DioException catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onDeleteComment(
      DeleteComment event, Emitter<CommentsState> emit) async {
    try {
      await pettygramRepository.deleteComment(
        event.commentId,
        Token(accessToken: storage.getString('accessToken')!),
      );

      final comments = state.comments
          .where((comment) => comment.id != event.commentId)
          .toList();

      emit(state.copyWith(status: Status.initial));
      emit(state.copyWith(status: Status.success, comments: comments));
    } on DioException catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onEditComment(
      EditComment event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(editStatus: Status.loading));

    try {
      final Comment newComment = await pettygramRepository.editComment(
        event.commentId,
        event.comment,
        Token(accessToken: storage.getString('accessToken')!),
      );

      final index = state.comments
          .indexWhere((commentObj) => commentObj.id == event.commentId);

      state.comments[index] = newComment;

      emit(state.copyWith(status: Status.initial));
      emit(
        state.copyWith(
            status: Status.success,
            comments: state.comments,
            editStatus: Status.success),
      );
    } on DioException catch (_) {
      emit(state.copyWith(editStatus: Status.failure));
    }
  }
}
