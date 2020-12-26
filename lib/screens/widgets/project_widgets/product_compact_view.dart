import 'package:flutter/material.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';

class ProductCompactView extends StatelessWidget {
  const ProductCompactView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: LayoutConstants.borderRadius,
        ),
        child: Wrap(
          children: <Widget>[
            Image.network(
                'https://cdn.pixabay.com/photo/2013/07/21/13/00/rose-165819__340.jpg'),
            Center(
              child: Text(
                "Flowers",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
