import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisisel_butce_yonetimi/utils/color.dart';

import 'grafik.dart';

class GelirGiderPieChartWidget2 extends ConsumerWidget {
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

        // Gelir ve gider verilerini al
        final gelirler = (data['gelir'] as Map<String, dynamic>).keys.toList();

        final gelirData = gelirler.map((gelir) {
          String icon;


          if (gelir == 'Prim') {
            icon = 'prim.png';
          } else if (gelir == 'Diğer') {
            icon = 'more.png';
          } else if (gelir == 'Maaş') {
            icon = 'maas.png';
          } else if (gelir == 'Kira') {
            icon = 'kira.png';
          }  else {
            icon = 'diger.png';
          }

          return GelirGiderData(
            gelir,
            (data['gelir'] as Map<String, dynamic>)[gelir] as double,
            icon: icon,
          );
        }).toList();

        final chart = GelirGiderPieChart(
          [...gelirData],
          colors: [turuncu, sari, pembe, yesil],
        );

        return chart;
      },
    );
  }
}
