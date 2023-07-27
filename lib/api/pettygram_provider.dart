import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';

abstract class IPettygramProvider {
  Future<List<User>> getUsers();
  Future<Token> loginRequest(LoginBody loginBody);
  Future<List<Post>> getPostsByUserId(String id);
}

class PettygramProvider implements IPettygramProvider {
  PettygramProvider(AppConfig config) {
    _dio.options.baseUrl = config.apiBaseUrl;
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

  @override
  Future<Token> loginRequest(LoginBody loginBody) async {
    final response = await _dio.post<dynamic>('/user/login',
        data: loginBody,
        options: Options(contentType: Headers.jsonContentType));
    return Token(accessToken: response.data['token']);
  }

  @override
  Future<List<Post>> getPostsByUserId(String id) async {
    final response = await _dio.get<dynamic>('/posts/$id');

    List<Post> posts = [];

    for (var json in response.data) {
      posts.add(Post.fromJson(json));
    }
    return posts;
  }
}
