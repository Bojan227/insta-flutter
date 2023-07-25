import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/models/token.dart';

class Login extends Equatable {
  Login({required this.token});

  Login.fromJson(Map<String, dynamic> json) {
    token = Token(accessToken: json['token']);
  }

  late Token token;

  @override
  List<Object?> get props => [token];
}
