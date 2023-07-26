import 'package:dio/dio.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';

abstract class IPettygramProvider {
  Future<List<User>> getUsers();
}

class PettygramProvider implements IPettygramProvider {
  PettygramProvider() {
    _dio.options.baseUrl =
        const AppConfig(apiBaseUrl: 'https://pettygram-api.onrender.com')
            .apiBaseUrl;
  }

  final Dio _dio = Dio();

  @override
  Future<List<User>> getUsers() async {
    final usersResponse = await _dio.get<dynamic>('/user');

    List<User> users = [];

    for (var user in usersResponse.data) {
      users.add(User.fromJson(user));
    }

    return users;
  }

  Future<Token> loginRequest(LoginBody loginBody) async {
    final response = await _dio.post<dynamic>('/user/login',
        data: loginBody,
        options: Options(contentType: Headers.jsonContentType));
    return Token(accessToken: response.data['token']);
  }
}
