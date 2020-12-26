import 'package:flutter/material.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';

class ServiceCompactView extends StatelessWidget {
  const ServiceCompactView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: ServiceCompactViewCard(),      
    );
  }
}

class ServiceCompactViewCard extends StatelessWidget {
  const ServiceCompactViewCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: LayoutConstants.borderRadius,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://nopstorageaccount.blob.core.windows.net/content/0000003_air-conditioning_450.png',
              color: Color(0XFFEA7623),
              height: 80,
              width: 80,
            ),
          ),
          Text('Ac Service')
        ],
      ),
    );
  }
}
