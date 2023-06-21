import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final cacheProvider = FutureProvider((ref)=>SharedPreferences.getInstance());

/*final cacheProvider = FutureProvider<SharedPreferences>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Önbelleği sıfırlama işlemi onboarding için
  await sharedPreferences.clear();

  return sharedPreferences;
});*/
