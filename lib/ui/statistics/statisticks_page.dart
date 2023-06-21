import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/ui/statistics/gellir_gider_charts.dart';
import '../../utils/color.dart';
import '../bildirimler/bildirimler.dart';
import '../home/Home2.dart';
import '../profil/profil_page.dart';
import 'gelir_charts.dart';
import 'gider_charts.dart';

class StatisticksPage extends ConsumerWidget {
  const StatisticksPage({Key? key}) : super(key: key);
  static const String route = "/istatistik";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final styles = theme.textTheme;
    final _controller = PageController();

    return Scaffold(
      backgroundColor: beyaz1,
      appBar: AppBar(
        title: Text("İstatistikler",style: styles.headlineSmall,),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: (){ Navigator.pop(context);},
        ),
        backgroundColor: beyaz1,


      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: gray1),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //transfer butonu
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          ImageIcon(AssetImage("Assets/icons/dollar.png"),color: siyah,size:35),
                          SizedBox(height: 5,),
                          Text(("Tümü"),style: styles.titleMedium?.copyWith(color: siyah)),
                        ]),
                      ),
                      onTap: (){
                        _controller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                    ),
                    VerticalDivider(
                      color: siyah,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    //ödeme butonu pay
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          ImageIcon(AssetImage("Assets/icons/gelir.png"),color: siyah,size:35),
                          SizedBox(height: 5,),
                          Text(("Gelirler"),style: styles.titleMedium?.copyWith(color: siyah)),
                        ]),
                      ),
                      onTap: (){
                        _controller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                    ),
                    VerticalDivider(
                      color: siyah,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          ImageIcon(AssetImage("Assets/icons/gider.png"),color: siyah,size:35),
                          SizedBox(height: 5,),
                          Text(("Giderler"),style: styles.titleMedium?.copyWith(color: siyah)),
                        ]),
                      ),
                      onTap: (){
                        _controller.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: PageView(
                controller: _controller,
                children: [
                  GelirGiderPieChartWidget(),
                  GelirGiderPieChartWidget2(),
                  GelirGiderPieChartWidget3()
                ],
              ),
            ),
          ],
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
              onTap: ()=> Navigator.pushNamed(context, HomePage2.route),
              child: ImageIcon(
                AssetImage("Assets/icons/homepage.png"),
                color: gray2,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, StatisticksPage.route),
              child: ImageIcon(
                AssetImage("Assets/icons/statistics.png"),
                color: turuncu1,
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
