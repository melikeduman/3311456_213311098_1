
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final harcamaEkleModelProvider =
    ChangeNotifierProvider((ref) => HarcamaEkleModel(ref));

class HarcamaEkleModel extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final Ref _ref;
  HarcamaEkleModel(this._ref);

  List<String> _sonIslemler = [];
  List<String> get sonIslemler => _sonIslemler;
  set sonIslemler(List<String> value) {
    _sonIslemler = value;
    notifyListeners();
  }


  List<String> _gelirler = [];
  List<String> get gelirler => _gelirler;
  set gelirler(List<String> value) {
    _gelirler = value;
    notifyListeners();
  }

  List<String> _giderler = [];
  List<String> get giderler => _giderler;
  set giderler(List<String> value) {
    _giderler = value;
    notifyListeners();
  }

  String _sonIslem = '';
  String get sonIslem => _sonIslem;
  set sonIslem(String value) {
    _sonIslem = value;
    notifyListeners();
  }


  double _gelir = 0;
  double get gelir => _gelir;
  set gelir(double gelir) {
    _gelir = gelir;
    notifyListeners();
  }

  String _geliradi = '';
  String get geliradi => _geliradi;
  set geliradi(String geliradi) {
    _geliradi = geliradi;
    notifyListeners();
  }

  bool _isGelir = false;
  bool get isGelir => _isGelir;
  set isGelir(bool value) {
    _isGelir = value;
    notifyListeners();
  }
  double _bakiye = 0;
  double get bakiye => _bakiye;
  set bakiye(double bakiye) {
    _bakiye = bakiye;
    notifyListeners();
  }
  double _toplamgelir = 0;
  double get toplamgelir => _toplamgelir;
  set toplamgelir(double toplamgelir) {
    _toplamgelir = toplamgelir;
    notifyListeners();
  }
  double _toplamgider = 0;
  double get toplamgider => _toplamgider;
  set toplamgider(double toplamgider) {
    _toplamgider = toplamgider;
    notifyListeners();
  }

  Future<void> harcamaEkle() async {
    try {
      final collection = firebaseFirestore.collection('gelirgider');
      final docId = '7cec93qhMp5PVyrYCvgS';

      final docSnapshot = await collection.doc(docId).get();
      final data = docSnapshot.data() as Map<String, dynamic>;

      if (isGelir) {
        final gelirMap = data['gelir'] as Map<String, dynamic>;
        final mevcutGelir = (gelirMap[geliradi] as num).toDouble() ?? 0.0;
        final yeniGelir = mevcutGelir + gelir.toDouble();

        gelirMap[geliradi] = yeniGelir;
        sonIslem = '$geliradi - +$gelir';

        // bakiyeyi güncelleme
        bakiye = (data['bakiye'] as num).toDouble() + gelir;
      }

      if (!isGelir) {
        final giderMap = data['gider'] as Map<String, dynamic>;
        final mevcutGider = (giderMap[geliradi] as num).toDouble() ?? 0.0;
        final yeniGider = mevcutGider + gelir.toDouble();

        giderMap[geliradi] = yeniGider;
        sonIslem = '$geliradi - -$gelir';

        // Bakiyeyi güncelle
        bakiye = (data['bakiye'] as num).toDouble() - gelir;
      }

      sonIslemler.add(sonIslem);
      toplamgelir = 0.0;
      toplamgider = 0.0;

      final gelirlerMap = data['gelir'] as Map<String, dynamic>;
      final giderlerMap = data['gider'] as Map<String, dynamic>;


      gelirlerMap.values.forEach((value) {
        if (value is double) {
          toplamgelir += value;
        }
      });


      giderlerMap.values.forEach((value) {
        if (value is double) {
          toplamgider += value;
        }
      });

      await collection.doc(docId).update({
        isGelir ? 'gelir' : 'gider': data[isGelir ? 'gelir' : 'gider'],
        'sonIslemler': sonIslemler,
        'toplamgelir': toplamgelir,
        'toplamgider': toplamgider,
        'bakiye': bakiye,
      });
    } catch (e) {
      print('Veri güncelleme işlemi hatası: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      final collection = firebaseFirestore.collection('gelirgider');
      final docId = '7cec93qhMp5PVyrYCvgS';

      final docSnapshot = await collection.doc(docId).get();
      final data = docSnapshot.data() as Map<String, dynamic>;

      // listeleri güncelleme
      gelirler = (data['gelir'] as Map<String, dynamic>).keys.toList();
      giderler = (data['gider'] as Map<String, dynamic>).keys.toList();
    } catch (e) {
      print('Firebase güncelleme işlemi hata: $e');
    }
  }
  Future<void> fetchData2() async {//toplam gelir ve gider gösterme
    try {
      final collection = firebaseFirestore.collection('gelirgider');
      final docId = '7cec93qhMp5PVyrYCvgS';

      final docSnapshot = await collection.doc(docId).get();
      final data = docSnapshot.data() as Map<String, dynamic>;

      sonIslemler = List<String>.from(data['sonIslemler']);
      toplamgelir = data['toplamgelir'] as double;
      toplamgider = data['toplamgider'] as double;
      bakiye = data['bakiye'] as double;
      gelirler = (data['gelir'] as Map<String, dynamic>).keys.toList();
      giderler = (data['gider'] as Map<String, dynamic>).keys.toList();
    } catch (e) {
      print('Veri alma işlemi hatası: $e');
    }
  }


  void resetData(WidgetRef ref) {
    final model = ref.read(harcamaEkleModelProvider.notifier);

    //  verileri sıfırla
    model.firebaseFirestore.collection('gelirgider').doc('7cec93qhMp5PVyrYCvgS').update({
      'gelir': {
        'Prim': 0,
        'Kira': 0,
        'Maaş': 0,
        'Diğer': 0,
      },
      'gider': {
        'Alışveriş': 0,
        'Akaryakıt': 0,
        'Fatura': 0,
        'Diğer': 0,
        'Sağlık': 0,
        'Seyahat': 0,
        'Yemek' : 0,
      },
      'sonIslemler': [],
      'toplamgelir': 0,
      'toplamgider': 0,
      'bakiye': 0,
    }).then((_) {
      // modeli günceller resetten sorna
      model.gelirler = [];
      model.giderler = [];
      model.sonIslemler = [];
      model.toplamgelir = 0;
      model.toplamgider = 0;
      model.bakiye = 0;
    });
  }

// ...
  void deleteSonIslem(int index) {
    if (index >= 0 && index < sonIslemler.length) {
      sonIslemler.removeAt(index);
      notifyListeners();
    }
  }

}
