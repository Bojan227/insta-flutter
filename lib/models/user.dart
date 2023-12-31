import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/models/post.dart';

class User extends Equatable {
  User({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.imageId,
    required this.imageUrl,
    required this.followers,
    required this.following,
    required this.saved,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];

    imageId = json['imageId'];
    imageUrl = json['imageUrl'];
    followers = json['followers'];
    following = json['following'];
    saved = json['saved'];
  }

  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? imageId;
  String? imageUrl;
  List<dynamic>? followers;
  List<dynamic>? following;
  List<dynamic>? saved;

  User copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    String? imageId,
    String? imageUrl,
    List<dynamic>? followers,
    List<dynamic>? following,
    List<dynamic>? saved,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageId: imageId ?? this.imageId,
      imageUrl: imageUrl ?? this.imageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      saved: saved ?? this.saved,
    );
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, "username": username, "imageUrl": imageUrl};

  bool isSaved(String postId) {
    return saved!.any((post) {
      final Post postCreated = Post(
          id: post['_id'],
          text: post['text'],
          createdBy: {"createdBy": post['createdBy']},
          imageUrl: post['imageUrl'],
          createdAt: post['createdAt']);

      return postCreated.id == postId;
    });
  }

  @override
  List<Object?> get props => [username, firstName, lastName, imageId, imageUrl];
}
