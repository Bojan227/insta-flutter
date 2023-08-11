import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/user.dart';

class Comment extends Equatable {
  String? id;
  String? comment;
  String? post;
  Map<String, dynamic>? createdBy;
  List<dynamic>? likes;
  String? createdAt;

  Comment(
      {required this.id,
      required this.comment,
      required this.post,
      required this.createdBy,
      required this.likes,
      required this.createdAt});

  Comment.fromJson(Map<String, dynamic> json) {
    comment = json["comment"];
    id = json['_id'];
    post = json['post'];
    createdBy = json['createdBy'];
    likes = json['likes'];
    createdAt = json['createdAt'];
  }

  bool isLiked() {
    return likes!.contains('63f76286810a293888d18152');
  }

  void updateLikes() {
    if (likes!.contains('63f76286810a293888d18152')) {
      likes!.remove('63f76286810a293888d18152');
    } else {
      likes!.add('63f76286810a293888d18152');
    }
  }

  @override
  List<Object?> get props => [id, comment, post, createdBy, likes, createdAt];
}
