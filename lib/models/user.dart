import 'package:equatable/equatable.dart';

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
  }

  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? imageId;
  String? imageUrl;
  List<dynamic>? followers;
  List<dynamic>? following;

  User copyWith(
      {String? id,
      String? username,
      String? firstName,
      String? lastName,
      String? imageId,
      String? imageUrl,
      List<dynamic>? followers,
      List<dynamic>? following}) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        imageId: imageId ?? this.imageId,
        imageUrl: imageUrl ?? this.imageUrl,
        followers: followers ?? this.followers,
        following: following ?? this.following);
  }

  @override
  List<Object?> get props => [username, firstName, lastName, imageId, imageUrl];
}
