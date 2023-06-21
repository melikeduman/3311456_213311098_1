import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/ui/provider/cache_provider.dart';
import '../utils/constant.dart';
import 'auth/kayit_sayfasi.dart';
import 'auth/providers/auth_view_model_provider.dart';
import 'home/Home2.dart';
import 'onboarding/onboarding.dart';

class Root extends ConsumerWidget {
  const Root({Key? key}) : super(key: key);
  static const String route = "/root";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seen =
    ref.read(cacheProvider).value?.getBool(Constants.seen) ?? true;
    final auth = ref.read(authViewModelProvider);
    return !seen
    ? const OnboardingPage()
        : auth.user != null
    ? HomePage2()
    : RegisterPage();

  }
}
