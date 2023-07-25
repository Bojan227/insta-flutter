import 'package:equatable/equatable.dart';

class Token extends Equatable {
  Token({required this.accessToken});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  late String accessToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
      };

  @override
  List<Object> get props => [accessToken];
}
