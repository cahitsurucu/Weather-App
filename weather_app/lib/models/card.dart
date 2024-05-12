import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final double temp;
  final String icon;
  final int time;
  const CardWidget(
      {super.key, required this.icon, required this.temp, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 150,
      child: Container(
        margin: const EdgeInsets.all(4),
        color: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(time.toString()),
            const SizedBox(
              height: 15,
            ),
            Image.network(
              'http:$icon',
              scale: 0.8,
            ),
            const SizedBox(
              height: 15,
            ),
            Text("$temp °C")
          ],
        ),
      ),
    );
  }
}
