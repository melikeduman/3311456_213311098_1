import 'package:flutter/material.dart';

import '../../utils/color.dart';

class MyCard extends StatelessWidget {
  final String bakiye1;
  final String gelir1;
  final String gider1;

  MyCard({
    required this.bakiye1,
    required this.gider1,
    required this.gelir1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:kmavi,
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey.shade900,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               const Text('TOPLAM BAKİYE',
                  style: TextStyle(color: gray1, fontSize: 16)),
              Text(
                '\₺' + bakiye1,
                style: const TextStyle(color:gray1, fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: gray1,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Gelir',
                                style: TextStyle(color: gray1)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('\₺' + gelir1,
                                style: const TextStyle(
                                    color: gray1,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: gray1,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Gider',
                                style: TextStyle(color: gray1)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('\₺' + gider1,
                                style: const TextStyle(
                                    color: gray1,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
