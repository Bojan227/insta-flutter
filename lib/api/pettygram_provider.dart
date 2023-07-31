import 'package:dio/dio.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/models/edit_body.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';

abstract class IPettygramProvider {
  Future<List<User>> getUsers();
  Future<Token> loginRequest(LoginBody loginBody);
  Future<List<Post>> getPostsByUserId(String id);
  Future<Post> addPost(PostBody postBody, Token token);
  Future<List<Post>> getPosts();
  Future<User> editUser(EditBody editBody, Token token);

  Future<Map<String, dynamic>> toggleBookmark(String postId, Token token);
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

  @override
  Future<Post> addPost(PostBody postBody, Token token) async {
    final response = await _dio.post<dynamic>(
      '/posts/',
      data: postBody,
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {"Authorization": "Bearer ${token.accessToken}"},
      ),
    );

    final postData = response.data;

    return Post.fromJson(postData);
  }

  @override
  Future<List<Post>> getPosts() async {
    final response = await _dio.get<dynamic>('/posts');

    List<Post> posts = [];

    for (var json in response.data['posts']) {
      posts.add(Post.fromJson(json));
    }
    return posts;
  }

  @override
  Future<Map<String, dynamic>> toggleBookmark(
      String postId, Token token) async {
    final response = await _dio.put<dynamic>(
      '/saved',
      data: {"postId": postId},
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {"Authorization": "Bearer ${token.accessToken}"},
      ),
    );

    final User user = User.fromJson(response.data['user']);

    Map<String, dynamic> createdBy = {
      "createdBy": response.data['post']['createdBy']
    };

    final Post post = Post(
        text: response.data['post']['text'],
        createdBy: createdBy,
        imageUrl: response.data['post']['imageUrl'],
        createdAt: response.data['post']['createdAt']);

    return {'user': user, 'post': post};
  }

  @override
  Future<User> editUser(EditBody editBody, Token token) async {
    final response = await _dio.put<dynamic>(
      '/user/edit',
      data: editBody,
      options:
          Options(headers: {"Authorization": "Bearer ${token.accessToken}"}),
    );

    print(response.data);

    User user = User.fromJson(response.data);

    return user;
  }
}
