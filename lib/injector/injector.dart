import 'package:get_it/get_it.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future setupInjector() async {
  final SharedPreferencesConfig sharedConfig =
      await SharedPreferencesConfig().initSharedPreferences();
  getIt.registerSingleton<SharedPreferencesConfig>(sharedConfig);
}
