import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/color.dart';
import '../home/Home2.dart';
import '../profil/profil_page.dart';
import '../statistics/statisticks_page.dart';

class BildirimlerPage extends StatefulWidget {
  static const String route = "/bildirimler";

  const BildirimlerPage({Key? key}) : super(key: key);

  @override
  _BildirimlerPageState createState() => _BildirimlerPageState();
}

class _BildirimlerPageState extends State<BildirimlerPage> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    final Uri url = Uri.parse('https://api.freecurrencyapi.com/v1/latest?apikey=VYNsDJ3noXkOMNgLox2RdunfYRv82CKEG4hB3Nq6');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> currencyList = data['data'] as Map<String, dynamic>;
      final filteredCurrencies = {'USD': currencyList['USD'], 'TRY': currencyList['TRY'], 'EUR': currencyList['EUR']};
      return {'data': filteredCurrencies};
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Scaffold(
      backgroundColor: beyaz1,
      appBar: AppBar(
        title: Text("Döviz Kurları",style: style.headlineSmall,),
        backgroundColor: beyaz1,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final currencyData = snapshot.data!['data'] as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(crossAxisCount: 2,childAspectRatio: 2/1,crossAxisSpacing: 15,children:
                [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),color: kmavi
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("USD",style: style.bodyMedium?.copyWith(color: beyaz),),
                          Image.asset('Assets/icons2/usa.png', width: 40, height: 40),
                          Text("${currencyData['USD']} \$",style: style.bodyMedium?.copyWith(color: beyaz),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("TRY",style: style.bodyMedium?.copyWith(color: beyaz),),
                          Image.asset('Assets/icons2/turkey.png', width: 40, height: 40),
                          Text("${currencyData['TRY']} \₺ ",style: style.bodyMedium?.copyWith(color: beyaz),)
                        ],
                      ),

                    ],
                  ),),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),color: kmavi
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("USD",style: style.bodyMedium?.copyWith(color: beyaz),),
                            Image.asset('Assets/icons2/usa.png', width: 40, height: 40),
                            Text("${currencyData['USD']} \$",style: style.bodyMedium?.copyWith(color: beyaz),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("TRY",style: style.bodyMedium?.copyWith(color: beyaz),),
                            Image.asset('Assets/icons2/europa.png', width: 40, height: 40),
                            Text("${currencyData['EUR']} \€ ",style: style.bodyMedium?.copyWith(color: beyaz),)

                          ],


                        ),

                      ],
                    ),),

                ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else {
              return Center(child: Text('Veri bulunamadı'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
              onTap: () => Navigator.pushNamed(context, StatisticksPage.route),
              child: ImageIcon(
                AssetImage("Assets/icons/statistics.png"),
                color: gray2,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, BildirimlerPage.route),
              child: ImageIcon(
                AssetImage("Assets/icons/bellring.png"),
                color: turuncu1,
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
