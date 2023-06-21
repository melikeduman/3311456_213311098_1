import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/ui/rooter.dart';
import 'package:kisisel_butce_yonetimi/utils/color.dart';
import 'package:kisisel_butce_yonetimi/utils/labels.dart';
import 'firebase_options.dart';
import 'ui/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final colorScheme = ColorScheme.fromSeed(seedColor: kmavi);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kişisel Bütçe Yönetimi',
      theme: ThemeData(

        cardTheme: const CardTheme(clipBehavior: Clip.antiAlias),
        useMaterial3: true,
        floatingActionButtonTheme: FloatingActionButtonThemeData(shape: CircleBorder()),
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        buttonTheme: const ButtonThemeData(
          shape: StadiumBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(headlineLarge: TextStyle(fontWeight: FontWeight.bold) ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),
      ),
      initialRoute: SplashPage.route,
      onGenerateRoute: AppRouter.onNavigate,
    );
  }
}
