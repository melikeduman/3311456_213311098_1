import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kisisel_butce_yonetimi/utils/assets.dart';
import 'package:lottie/lottie.dart';

import '../../utils/color.dart';
import '../../utils/constant.dart';
import '../../utils/labels.dart';
import '../provider/cache_provider.dart';
import '../root.dart';

class OnboardingItem {
  final String resim;
  final String baslik;
  final String aciklama;

  const OnboardingItem(
      {required this.baslik, required this.aciklama, required this.resim});
}

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({Key? key}) : super(key: key);
  static const String route = "/onboarding";
  static const List<OnboardingItem> _items = [
    OnboardingItem(
        resim: LottieAssets.giris,
        baslik: Labels.giris,
        aciklama: Labels.girisA),
    OnboardingItem(
        resim: LottieAssets.gelisme,
        baslik: Labels.gelisme,
        aciklama: Labels.gelismeA),
    OnboardingItem(
        resim: LottieAssets.sonuc,
        baslik: Labels.sonuc,
        aciklama: Labels.sonucA),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final controller = useTabController(initialLength: _items.length);
    final index=useState(0);
    void done() async{
      await ref.read(cacheProvider).value!.setBool(Constants.seen, true);
      Navigator.pushReplacementNamed(context, Root.route);
    }
    controller.addListener(() {
      if(index.value!= controller.index){
        index.value = controller.index;
      }
    });
    return Scaffold(
      
      backgroundColor: theme.cardColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: done,
              child: Text("Atla"),
            ),
            MaterialButton(
                color: kmavi,
                onPressed: () {
                  if (controller.index < 2) {
                    index.value = index.value + 1;
                    controller.animateTo(controller.index + 1);
                  } else {
                    done();
                  }
                },
              child: Text(index.value == 2?"DONE":"NEXT"),
            ),],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: _items
            .map(
              (e) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Expanded(flex: 32, child: Lottie.asset(e.resim)),
                Spacer(),
                Text(
                  e.baslik,
                  style: style.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                Spacer(
                ),
                Text(
                  e.aciklama,
                  style: style.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Spacer(
                  flex: 8,
                ),
              ],
            ),
          ),
        )
            .toList(),
      ),
      bottomSheet: Material(
        color: theme.cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _items.length,
                  (i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: index.value == i
                        ? turuncu1
                        : turuncu,
                  ),
                  child: AnimatedSize(
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 16,
                      width: index.value == i ? 32 : 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),


    );
  }
}
