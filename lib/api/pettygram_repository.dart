import 'package:pettygram_flutter/models/edit_body.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';

import '../models/comment.dart';
import '../models/comment_body.dart';

abstract class IPettygramRepository {
  Future<List<User>> getUsers();
  Future<Token> loginRequest(LoginBody loginBody);
  Future<List<Post>> getPosts(int page);
  Future<List<Post>> getPostsByUserId(String id);
  Future<Post> addPost(PostBody postBody, Token token);
  Future<Map<String, dynamic>> toggleBookmark(String postId, Token token);
  Future<User> editUser(EditBody editBody, Token token);
  Future<User> getUserById(String userId);
  Future<List<Comment>> getCommentsByPostId(String postId);
  Future<String> addComment(CommentBody commentBody, Token token);
  Future<User> updateProfilePicture(List<String> image, Token token);
  Future<Comment> toggleCommentLike(String commentId, Token token);
  Future<String> deleteComment(String commentId, Token token);
}
