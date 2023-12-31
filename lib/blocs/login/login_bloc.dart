import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/models/firebase_user.dart';
import 'package:pettygram_flutter/models/login.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/user.dart';

import '../../models/token.dart';
import '../../storage/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.pettygramRepository, required this.storageConfig})
      : super(LoginInitial()) {
    on<LoginRequest>(onLoginRequest);
  }

  final PettygramRepository pettygramRepository;
  final SharedPreferencesConfig storageConfig;

  Future<void> onLoginRequest(
      LoginRequest event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final Map<String, dynamic> data =
          await pettygramRepository.loginRequest(event.loginBody);

      final Token token = data['token'];
      final FirebaseUser user = data['user'];

      storageConfig.saveString('accessToken', token.accessToken);
      storageConfig.saveString('accessUser', user.toJson());

      emit(
        LoginSuccess(
          login: Login(
            token: token,
          ),
        ),
      );
    } on DioException catch (error) {
      emit(LoginFailed(error: error.response?.data['error']));
    }
  }
}
