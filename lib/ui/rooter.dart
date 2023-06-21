import 'package:flutter/material.dart';
import 'package:kisisel_butce_yonetimi/ui/Harcama/harcama_ekle.dart';
import 'package:kisisel_butce_yonetimi/ui/auth/login_page.dart';
import 'package:kisisel_butce_yonetimi/ui/bildirimler/bildirimler.dart';
import 'package:kisisel_butce_yonetimi/ui/home/Home2.dart';
import 'package:kisisel_butce_yonetimi/ui/profil/profil_page.dart';
import 'package:kisisel_butce_yonetimi/ui/profil/profil_page_update.dart';
import 'package:kisisel_butce_yonetimi/ui/root.dart';
import 'package:kisisel_butce_yonetimi/ui/splash/splash_page.dart';
import 'package:kisisel_butce_yonetimi/ui/statistics/statisticks_page.dart';
import 'package:kisisel_butce_yonetimi/ui/bildirimler/bildirimler.dart';

import 'auth/kayit_sayfasi.dart';

class AppRouter {
  static Route<MaterialPageRoute> onNavigate(RouteSettings settings) {
    late final Widget selectedPage;

    switch (settings.name) {
      case SplashPage.route:
        selectedPage = const SplashPage();
        break;
      case RegisterPage.route:
        selectedPage = RegisterPage();
        break;
      case BildirimlerPage.route:
        selectedPage =  BildirimlerPage();
        break;
      case LoginPage.route:
        selectedPage = LoginPage();
        break;

      case HarcamaEklePage.route:
        selectedPage =  HarcamaEklePage();
        break;
      case StatisticksPage.route:
        selectedPage = const StatisticksPage();
        break;
      case ProfilPageUpdate.route:
        selectedPage = const ProfilPageUpdate();
        break;
      case ProfilPage.route:
        selectedPage = const ProfilPage();
        break;
      case HomePage2.route:
        selectedPage =  HomePage2();
        break;


      default:
        selectedPage = const Root();
        break;
    }

    return MaterialPageRoute(builder: (context) => selectedPage);
  }
}