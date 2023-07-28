import 'package:equatable/equatable.dart';

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

  bool isLiked(String id) {
    return likes!.any((like) => like == id);
  }

  @override
  List<Object?> get props => [id, text, createdBy, imageUrl];
}
