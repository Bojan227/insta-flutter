import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../storage/shared_preferences.dart';

class Post extends Equatable {
  Post(
      {this.id,
      required this.text,
      required this.createdBy,
      required this.imageUrl,
      required this.createdAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    text = json['text'];
    createdBy = json['createdBy'];
    imageUrl = json['imageUrl'];
    imageId = json['imageId'];
    createdAt = json['createdAt'];
    likes = json['likes'];
  }

  String? id;
  String? text;
  Map<String, dynamic>? createdBy;
  List<dynamic>? imageUrl;
  List<dynamic>? imageId;
  String? createdAt;
  List<dynamic>? likes;

  bool isLiked(SharedPreferencesConfig storage) {
    final bool isKeyPresent = storage.isKeyPresent('accessUser');

    if (!isKeyPresent) return false;

    final Map<String, dynamic> currentUser =
        jsonDecode(storage.getString('accessUser')!);

    return likes!.any((like) => like == currentUser['id']);
  }

  @override
  List<Object?> get props => [id, text, createdBy, imageUrl];
}
