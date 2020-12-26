import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

class PackageCompactViewWidget extends StatelessWidget {
  final ProductDto product;
  const PackageCompactViewWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 400.0,
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: LayoutConstants.shapeBorderRadius8,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            // SvgPicture.asset(
            //   "assets/images/package.svg",
            //   color: Colors.black,
            //   width: 40.0,
            //   height: 40.0,
            // ),
            SizedBox(
              height: 16,
            ),
            Text(
              this.product.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Divider(
                color: Color(0XFFEA7623),
                height: 5,
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                'Starting at',
                style: TextStyle(fontSize: 10.0),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: 'AED 121',
                  style: TextStyle(color: Color(0XFFEA7623)),
                  children: <TextSpan>[
                    TextSpan(
                        text: '/month', style: TextStyle(color: Colors.black))
                  ]),
            )

            //Image.network(
            //  'https://cdn.pixabay.com/photo/2013/07/21/13/00/rose-165819__340.jpg'),
          ],
        ),
      ),
    );
  }
}
