import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisisel_butce_yonetimi/utils/color.dart';

import 'grafik.dart';

class GelirGiderPieChartWidget extends ConsumerWidget {
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
        // verileri alma
        final toplamGelir = data['toplamgelir'] as double;
        final toplamGider = data['toplamgider'] as double;


        final toplamData = [
          GelirGiderData('Toplam Gelir', toplamGelir, icon:'up.png'),
          GelirGiderData('Toplam Gider', toplamGider, icon: 'down.png'),
        ];

        final chart = GelirGiderPieChart([...toplamData], colors: [yesil,kirmizi],);

        return chart;

      },
    );
  }
}
