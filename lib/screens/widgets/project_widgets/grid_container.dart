import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';

class GridContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      child: Card(
        //for cutting the corners of cards
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.orange, width: 2),
          borderRadius: LayoutConstants.borderRadius,
        ),
        elevation: 15.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://i.ytimg.com/vi/Hd3iBpUpgeg/maxresdefault.jpg',
              height: 110.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Divider(
              color: Colors.orange,
              thickness: 2.0,
              height: 1.0,
            ),
//            SizedBox(
//              height: 15.0,
//            ),
            Container(
                //width: double.infinity,
                child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cleaning Service',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ))
          ],
        ),
      ),
    );
    ;
  }
}
