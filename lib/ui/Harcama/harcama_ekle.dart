import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/ui/Harcama/providers/harcama_ekle_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/color.dart';

class HarcamaEklePage extends ConsumerWidget {
  HarcamaEklePage({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
  static const String route = "/harcama";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(harcamaEkleModelProvider);


    return  AlertDialog(
      title: Text('Yeni İşlem'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Gider'),
                Switch(
                  activeColor: kmavi,
                  value: model.isGelir,
                  onChanged: (value) async {
                    model.isGelir = value;
                    model.fetchData();
                  },
                ),
                Text('Gelir'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formkey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Miktar?',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Miktar giriniz!';
                        }
                        return null;
                      },
                      onChanged: (v) => model.gelir = double.parse(v),

                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final model = ref.watch(harcamaEkleModelProvider);

                      return buildDropdownMenu(model, ref);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          color: kmavi,
          child:
          Text('İptal', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          color: kmavi,
          child: Text('Ekle', style: TextStyle(color: Colors.white)),
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              await model.harcamaEkle();
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
  DropdownButtonFormField<String> buildDropdownMenu(
      HarcamaEkleModel model,
      WidgetRef ref,
      ) {
    final List<String> options = model.isGelir ? model.gelirler : model.giderler;

    return DropdownButtonFormField<String>(
      value: options.isNotEmpty ? options[0] : null,
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          ref.read(harcamaEkleModelProvider).geliradi = newValue;
        }
      },
    );
  }

}

