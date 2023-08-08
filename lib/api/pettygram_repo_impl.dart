import 'package:pettygram_flutter/api/pettygram_provider.dart';
import 'package:pettygram_flutter/api/pettygram_repository.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/models/comment.dart';
import 'package:pettygram_flutter/models/comment_body.dart';
import 'package:pettygram_flutter/models/edit_body.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';

class PettygramRepository implements IPettygramRepository {
  final PettygramProvider _provider = getIt<PettygramProvider>();

  @override
  Future<List<User>> getUsers() async {
    return await _provider.getUsers();
  }

  @override
  Future<Token> loginRequest(LoginBody loginBody) async {
    return await _provider.loginRequest(loginBody);
  }

  @override
  Future<List<Post>> getPostsByUserId(String id) async {
    return await _provider.getPostsByUserId(id);
  }

  @override
  Future<Post> addPost(PostBody postBody, Token token) async {
    return await _provider.addPost(postBody, token);
  }

  @override
  Future<List<Post>> getPosts(String page) async {
    return await _provider.getPosts(page);
  }

  @override
  Future<Map<String, dynamic>> toggleBookmark(
      String postId, Token token) async {
    return await _provider.toggleBookmark(postId, token);
  }

  @override
  Future<User> editUser(EditBody editBody, Token token) async {
    return await _provider.editUser(editBody, token);
  }

  @override
  Future<User> getUserById(String userId) async {
    return await _provider.getUserById(userId);
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    return await _provider.getCommentsByPostId(postId);
  }

  @override
  Future<String> addComment(CommentBody commentBody, Token token) async {
    return await _provider.addComment(commentBody, token);
  }
}
