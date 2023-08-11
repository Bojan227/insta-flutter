import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

import '../../../../models/token.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final PettygramRepository pettygramRepo;
  final SharedPreferencesConfig storage;

  CommentCubit({required this.pettygramRepo, required this.storage})
      : super(
          const CommentState(commentStatus: CommentStatus.initial, message: ''),
        );

  Future<void> toggleCommentLike(String postId) async {
    try {
      final successMessage = await pettygramRepo.toggleCommentLike(
          postId, Token(accessToken: storage.getString('accessToken')!));

      emit(CommentState(
          commentStatus: CommentStatus.success, message: successMessage));
    } on DioException catch (_) {
      emit(const CommentState(
          commentStatus: CommentStatus.failure, message: 'Failed to update'));
    }
  }
}
