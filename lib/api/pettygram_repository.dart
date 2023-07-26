import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/models/user.dart';

abstract class IPettygramRepository {
  Future<List<User>> getUsers();
  Future<Token> loginRequest(LoginBody loginBody);
}
