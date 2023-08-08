import 'package:dio/dio.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/models/edit_body.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';

import '../models/comment.dart';
import '../models/comment_body.dart';

abstract class IPettygramProvider {
  Future<List<User>> getUsers();
  Future<Token> loginRequest(LoginBody loginBody);
  Future<List<Post>> getPostsByUserId(String id);
  Future<Post> addPost(PostBody postBody, Token token);
  Future<List<Post>> getPosts(String page);
  Future<User> editUser(EditBody editBody, Token token);
  Future<User> getUserById(String userId);
  Future<Map<String, dynamic>> toggleBookmark(String postId, Token token);
  Future<List<Comment>> getCommentsByPostId(String postId);
  Future<String> addComment(CommentBody commentBody, Token token);
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
      data: postBody.toJson(),
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {"Authorization": "Bearer ${token.accessToken}"},
      ),
    );

    final postData = response.data;

    return Post.fromJson(postData);
  }

  @override
  Future<List<Post>> getPosts(String page) async {
    final response = await _dio.get<dynamic>('/posts/?page=$page');

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
      data: editBody.toJson(),
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {"Authorization": "Bearer ${token.accessToken}"},
      ),
    );

    User user = User.fromJson(response.data);

    return user;
  }

  @override
  Future<User> getUserById(String userId) async {
    final response = await _dio.get<dynamic>(
      '/user/$userId',
    );

    User user = User.fromJson(response.data);

    return user;
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final res = await _dio.get<dynamic>('/posts/$postId/comments');

    List<Comment> comments = [];

    for (var json in res.data) {
      comments.add(Comment.fromJson(json));
    }

    return comments;
  }

  @override
  Future<String> addComment(CommentBody commentBody, Token token) async {
    final res = await _dio.post<dynamic>(
      '/comments/',
      data: commentBody.toJson(),
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {"Authorization": "Bearer ${token.accessToken}"},
      ),
    );

    return res.data['message'];
  }
}
