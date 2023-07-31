import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/edit_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserStateCubit> {
  UserCubit({required this.pettygramRepository, required this.storage})
      : super(UserInitial());

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storage;

  Future<void> loadUser(String userId) async {
    emit(UserLoading());

    try {
      User bookmarkResponse = await pettygramRepository.getUserById(
        userId,
      );

      emit(
        UserLoaded(
          user: bookmarkResponse,
        ),
      );
    } on DioException catch (error) {
      print(error.response);
      emit(UserFailed());
    }
  }

  Future<void> editUser(EditBody editBody) async {
    emit(UserEditInProgress());

    try {
      User bookmarkResponse = await pettygramRepository.editUser(
        editBody,
        Token(accessToken: storage.getString('accessToken')!),
      );

      emit(
        UserEditSuccess(
          user: bookmarkResponse,
        ),
      );
    } on DioException catch (error) {
      print(error.response);
      emit(UserEditFailed(error: error.response?.data['error']));
    }
  }
}
