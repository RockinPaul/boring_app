import 'package:flutter/material.dart';

class PriceIndicator extends StatelessWidget {
  final double price;

  const PriceIndicator({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0,
      height: 50.0,
      child: ClipOval(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // LinearProgressIndicator(
            //   value: 0.5,
            //   semanticsLabel: 'Price indicator',
            //   minHeight: 50.0,
            // ),
            ColorFiltered(
                colorFilter: ColorFilter.linearToSrgbGamma(),
                child: Image.asset(
                  'assets/images/euro.png',
                  width: 50.0,
                )),
          ],
        ),
      ),
    );
  }
}
