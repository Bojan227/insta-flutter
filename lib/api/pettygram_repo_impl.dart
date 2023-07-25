import 'package:pettygram_flutter/api/pettygram_provider.dart';
import 'package:pettygram_flutter/api/pettygram_repository.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/models/user.dart';

class PettygramRepository implements IPettygramRepository {
  final PettygramProvider _provider = getIt<PettygramProvider>();

  @override
  Future<List<User>> getUsers() async {
    return await _provider.getUsers();
  }
}
