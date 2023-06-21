import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/core/repositories/user_repository_provider.dart';
import 'package:kisisel_butce_yonetimi/ui/Harcama/providers/harcama_ekle_provider.dart';
import 'package:kisisel_butce_yonetimi/ui/auth/login_page.dart';
import 'package:kisisel_butce_yonetimi/ui/auth/providers/auth_view_model_provider.dart';
import 'package:kisisel_butce_yonetimi/ui/profil/profil_page_update.dart';
import 'package:kisisel_butce_yonetimi/ui/profil/provider/profil_page_provider.dart';

import '../../core/models/user.dart';
import '../../utils/color.dart';
import '../Harcama/harcama_ekle.dart';
import '../bildirimler/bildirimler.dart';
import '../home/Home2.dart';
import '../statistics/statisticks_page.dart';
import '../widgets/my_profile_menu.dart';

class ProfilPage extends ConsumerWidget {
  const ProfilPage({Key? key}) : super(key: key);
  static const String route = "/profilpage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;

    final model = ref.watch(updateUserViewModelProvider);
    final model2 = ref.watch(harcamaEkleModelProvider);
    final model3 = ref.read(authViewModelProvider);

    // Firestore'dan kullanıcı bilgilerini almak için
    final userStream =
        ref.watch(userRepositoryProvider).getUserById(model.initial.id);

    return Scaffold(
      backgroundColor: beyaz1,
      appBar: AppBar(
        backgroundColor: beyaz1,
        title: Text(
          "Profil",
          style: style.headlineSmall,
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: StreamBuilder<DocumentSnapshot>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final user = UserModel.fromFirestore(snapshot.data!);

              return Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(user.image),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user.name, style: theme.textTheme.headlineMedium),
                        Text(
                          user.surname,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    ProfileMenu(
                        text: 'Profili Düzenle',
                        icon: Icons.person_sharp,
                        press: () => Navigator.pushNamed(
                            context, ProfilPageUpdate.route)),
                    ProfileMenu(
                        text: 'Verileri Sıfırla',
                        icon: Icons.restart_alt,
                        press: () {
                          model2.resetData(ref);
                        }),
                    ProfileMenu(
                      text: 'Çıkış Yap',
                      icon: Icons.logout,
                      press: () {
                        model3.logout();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginPage.route,
                          (Route<dynamic> route) =>
                              false, // Geri düğmesiyle dönüşü engellemek için
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: beyaz,
        elevation: 1,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        height: 65,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, HomePage2.route),
              child: ImageIcon(
                AssetImage("Assets/icons/homepage.png"),
                color: gray2,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, StatisticksPage.route),
              child: ImageIcon(
                AssetImage("Assets/icons/statistics.png"),
                color: gray2,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, BildirimlerPage.route),
              child: ImageIcon(
                AssetImage("Assets/icons/bellring.png"),
                color: gray2,
              ),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, ProfilPage.route),
              child: ImageIcon(
                AssetImage("Assets/icons/user.png"),
                color: turuncu1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
