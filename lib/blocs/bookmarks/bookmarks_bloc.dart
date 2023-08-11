import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

import '../../models/post.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc({required this.storage, required this.pettygramRepository})
      : super(const BookmarksState(
            bookmarkedPosts: [],
            status: BookmarkStatus.initial,
            errorMessage: "")) {
    on<GetBookmarks>(_onGetBookmarks);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> _onGetBookmarks(GetBookmarks event, Emitter emit) async {
    emit(state.copyWith(status: BookmarkStatus.loading));

    try {
      final bookmarkedPosts =
          await pettygramRepository.getBookmarkedPostsByUser(
        Token(accessToken: storage.getString('accessToken')!),
      );

      emit(state.copyWith(
          status: BookmarkStatus.success, bookmarkedPosts: bookmarkedPosts));
    } on DioException catch (error) {
      emit(state.copyWith(
          status: BookmarkStatus.failure,
          errorMessage: error.response?.data['error']));
    }
  }
}
