import 'package:pettygram_flutter/models/user.dart';

abstract class IPettygramRepository {
  Future<List<User>> getUsers();
}
