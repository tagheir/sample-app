import 'package:bluebellapp/models/category_dto.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:flutter/material.dart';

class LandscapeServicesGrid extends StatelessWidget {
  final List<CategoryDto> categories;
  LandscapeServicesGrid({this.categories});
  containerFunction({String service_name, String imageURL}) {
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
              imageURL,
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
                service_name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: categories?.length == 0
          ? DataEmpty(message: 'No landscape services to show')
          : GridView.count(
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              padding: EdgeInsets.all(10.0),
              crossAxisCount: 2,
              children: List.generate(categories.length, (index) {
                return containerFunction(
                    service_name: categories[index].name,
                    imageURL:
                        'https://i.ytimg.com/vi/Hd3iBpUpgeg/maxresdefault.jpg');
              }),
            ),
    )

//

        );
  }
}
