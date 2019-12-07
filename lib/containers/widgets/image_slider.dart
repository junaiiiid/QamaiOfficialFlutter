import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:qamai_official/constants.dart';

class CarouselPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300.0,
        width: 350.0,
        child: Carousel(
          overlayShadowColors: QamaiThemeColor,
          images: [
            Image.asset('images/image_1.png'),
            Image.asset('images/image_2.png'),
            Image.asset('images/image_3.png'),
            Image.asset('images/image_4.png'),
            Image.asset('images/image_5.png'),
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: BlackMaterial,
          dotIncreasedColor: QamaiGreen,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.transparent,
          borderRadius: false,
          autoplayDuration: Duration(seconds: 4),
        )
    );
  }
}