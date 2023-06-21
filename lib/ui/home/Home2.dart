import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/ui/bildirimler/bildirimler.dart';
import 'package:kisisel_butce_yonetimi/ui/statistics/statisticks_page.dart';
import 'package:kisisel_butce_yonetimi/ui/widgets/cart1.dart';
import '../../utils/color.dart';
import '../Harcama/harcama_ekle.dart';
import '../Harcama/providers/harcama_ekle_provider.dart';
import '../profil/profil_page.dart';

class HomePage2 extends ConsumerWidget {
  static const String route = "/hom";
  HomePage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(harcamaEkleModelProvider);
    final container = ref.read(harcamaEkleModelProvider.notifier);
    final container2 = ref.read(harcamaEkleModelProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      container.fetchData2();
    });

    return Scaffold(
      backgroundColor: beyaz1,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            MyCard(
                bakiye1: model.bakiye.toString(),
                gider1: model.toplamgider.toString(),
                gelir1: model.toplamgelir.toString()),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,

                          itemCount: model.sonIslemler.length,
                          itemBuilder: (context, index) {
                            final sonIslem = model.sonIslemler[index];
                            final splitIndex = sonIslem.lastIndexOf(' - ');
                            final geliradi = sonIslem.substring(0, splitIndex);
                            final gelir = sonIslem.substring(splitIndex + 4);
                            final isGelir = sonIslem.contains('+');
                            final renk = isGelir ? Colors.green : Colors.red;
                            final isaret = isGelir ? '+' : '-';
                            final icon = isGelir
                                ? Icon(
                                    Icons.arrow_upward,
                                    color: yesil,
                                  )
                                : Icon(
                                    Icons.arrow_downward,
                                    color: kirmizi,
                                  );

                            return GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Sil'),
                                    content: Text(
                                        'Bu öğeyi silmek istediğinize emin misiniz?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          container2.deleteSonIslem(index);

                                        },
                                        child: Text('Sil'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('İptal'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child:Padding(
                                padding: const EdgeInsets.only(bottom:12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    color: gray1,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: gray),
                                              child: Center(child: icon),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(geliradi,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: siyah,
                                                )),
                                          ],
                                        ),
                                        Text(
                                          '$isaret $gelir ₺',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: renk,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.pushNamed(context, HarcamaEklePage.route),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: turuncu1,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '+',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              onTap: ()=> Navigator.pushReplacementNamed(context, HomePage2.route),
              child: ImageIcon(
                AssetImage("Assets/icons/homepage.png"),
                color: turuncu1,
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
              onTap: () => Navigator.pushNamed(context, ProfilPage.route),
              child: ImageIcon(
                AssetImage("Assets/icons/user.png"),
                color: gray2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
