// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class FirebaseUser extends Equatable {
  const FirebaseUser(
      {required this.id,
      required this.username,
      required this.imageUrl,
      required this.token});

  final String id;
  final String username;
  final String imageUrl;
  final String token;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'imageUrl': imageUrl,
      'token': token,
    };
  }

  factory FirebaseUser.fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      id: map['id'] as String,
      username: map['username'] as String,
      imageUrl: map['imageUrl'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseUser.fromJson(String source) =>
      FirebaseUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [id, imageUrl, username, token];
}
