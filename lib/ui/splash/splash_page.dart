import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../utils/color.dart';
import '../provider/cache_provider.dart';
import '../root.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String route = "/";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> with TickerProviderStateMixin {

  late AnimationController _animationController;
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationController.forward().whenComplete(() {
      Navigator.pushNamedAndRemoveUntil(context, Root.route, (route) => false);
    });
    super.initState();
    init();
  }

  void init() async {
    await ref.read(cacheProvider.future);

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmavi,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'Assets/lottie/wallet2.json',
              width: 300,
              height: 300,
              controller: _animationController,
            ),
            const SizedBox(height: 5,),

          ],
        ),
      ),
    );
  }
}