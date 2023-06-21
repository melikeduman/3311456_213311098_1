import 'package:flutter/material.dart';
import 'package:kisisel_butce_yonetimi/utils/color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GelirGiderPieChart extends StatelessWidget {

  final List<GelirGiderData> data;
  final List<Color> colors;

  GelirGiderPieChart(this.data, {required this.colors});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    double totalGider = 0.0;

    // Toplam gideri hesapla
    data.forEach((item) {
      totalGider += item.gideradi;
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250, // Pie Chart'ın istediğiniz boyutunu ayarlayın
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries<GelirGiderData, String>(
                  dataSource: data,
                  xValueMapper: (GelirGiderData data, _) => data.geliradi,
                  yValueMapper: (GelirGiderData data, _) => data.gideradi,
                  dataLabelMapper: (GelirGiderData data, _) =>
                  '${(data.gideradi / totalGider * 100).toStringAsFixed(2)}%',
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                ),
              ],
              palette: colors,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: data.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    backgroundColor: gray1,
                  ),
                  onPressed: (){},
                  child: Row(
                    children: [
                      Image.asset('Assets/icons2/${item.icon}',width: 22,height: 22,),
                      SizedBox(width: 10),
                      Expanded(child: Text('${item.geliradi}: ',style: style.bodyLarge?.copyWith(color: Colors.black),)),
                      Text('${item.gideradi.toStringAsFixed(2)} ₺',style: style.bodyLarge,),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}


class GelirGiderData {
  final String geliradi;
  final double gideradi;
  final String icon;

  GelirGiderData(this.geliradi, this.gideradi, {required this.icon});
}
