import 'package:flutter/material.dart';

import 'icon_text_card.dart';

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (_, index) {
          return IconTextCard(
            icon: Icons.backup,
            text: 'Winter',
            subText: 'Sub Info Winter',
            cardColor: Colors.white,
            textColor: Colors.black,
          );
        },
      ),
    );
  }
}
