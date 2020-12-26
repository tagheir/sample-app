import 'package:bluebellapp/screens/widgets/helper_widgets/common.dart';
import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String name;
  final double price;
  final String picture;

  FeaturedCard(
      {@required this.name, @required this.price, @required this.picture});

  @override
  Widget build(BuildContext context) {
    var card = Container(
      padding: const EdgeInsets.all(24.0),
      width: 170,
      height: 170,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
                color: Colors.amber,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.notifications,
                      color: Colors.white, size: 30.0),
                )),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            Text('Alerts',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0)),
            Text('All ', style: TextStyle(color: Colors.black45)),
          ]),
    );
    return Common.buildTile(card);
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          //Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetails()));
        },
        child: card,
      ),
    );
  }
}
