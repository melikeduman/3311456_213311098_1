import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisisel_butce_yonetimi/utils/color.dart';

import 'grafik.dart';

class GelirGiderPieChartWidget3 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = FirebaseFirestore.instance.collection('gelirgider');
    final docId = '7cec93qhMp5PVyrYCvgS';

    return FutureBuilder<DocumentSnapshot>(
      future: collection.doc(docId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        }

        final data = snapshot.data?.data() as Map<String, dynamic>?;

        if (data == null) {
          return Text('Veri bulunamadı');
        }

        final giderler = (data['gider'] as Map<String, dynamic>).keys.toList();

        final giderData = giderler
            .map((gider) {
          String icon;

          if (gider == 'Yemek') {
            icon = 'yemek1.png';
          } else if (gider == 'Seyahat') {
            icon = 'seyahat1.png';
          }
          else if (gider == 'Akaryakıt') {
            icon = 'gas1.png';
          }
          else if (gider == 'Sağlık') {
            icon = 'saglik1.png';
          }
          else if (gider == 'Fatura') {
            icon = 'faturalar1.png';
          }
          else if (gider == 'Alışveriş') {
            icon = 'alisveris1.png';
          }
          else if (gider == 'Diğer') {
            icon = 'diger1.png';
          } else {
            icon = 'diger.png';
          }

          return GelirGiderData(gider, (data['gider'] as Map<String, dynamic>)[gider] as double, icon: icon);
        })
            .toList();

        //piecahrtı oluşturma
        final chart = GelirGiderPieChart(
          [...giderData],
          colors: [kirmizi, sari, mavi, yesil, mor, turuncu,pembe],
        );

        return chart;
      },
    );
  }
}
