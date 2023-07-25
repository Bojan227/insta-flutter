import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pettygram_flutter/models/login.dart';
import 'package:pettygram_flutter/models/login_body.dart';

import '../../models/token.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.dio}) : super(LoginInitial()) {
    on<LoginRequest>(onLoginRequest);
  }

  final Dio dio;

  Future<void> onLoginRequest(
      LoginRequest event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final response = await dio.post<dynamic>('/user/login',
          data: event.loginBody.toJson());

      emit(LoginSuccess(
          login: Login(token: Token(accessToken: response.data['token']))));
    } on DioException catch (error) {
      emit(LoginFailed(error: error.message!));
    }
  }
}
