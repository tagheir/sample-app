import 'package:bluebellapp/models/category_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final List<CategoryDto> categories;
  ProductsGrid({this.categories});

  containerFunction({String serviceName, String imageURL}) {
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
            Image.network(imageURL,
                height: 110.0, width: double.infinity, fit: BoxFit.cover),
            Divider(color: LightColor.orange, thickness: 2.0, height: 1.0),
//            SizedBox(
//              height: 15.0,
//            ),
            Container(
                padding: LayoutConstants.edgeInsets8,
                child: Text(
                  serviceName,
                  textAlign: TextAlign.center,
                  style: TextConstants.H6,
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var body = List<Widget>();
    // body.add(categories == null
    //     ? DataEmpty(message: 'No products to show')
    //     : GridView.count(
    //         mainAxisSpacing: 20.0,
    //         crossAxisSpacing: 20.0,
    //         padding: EdgeInsets.all(10.0),
    //         crossAxisCount: 2,
    //         children: List.generate(categories?.length, (index) {
    //           return containerFunction(
    //               serviceName: categories[index].name,
    //               imageURL:
    //                   'https://i.ytimg.com/vi/Hd3iBpUpgeg/maxresdefault.jpg');
    //         })));
    // return LayoutScreen(
    //   showDefaultBackButton: true,
    //   body: Column(children: body),
    // );
    return SafeArea(
        child: Scaffold(
      body: categories == null
          ? DataEmpty(message: 'No products to show')
          : GridView.count(
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              padding: EdgeInsets.all(10.0),
              crossAxisCount: 2,
              children: List.generate(categories?.length, (index) {
                return containerFunction(
                    serviceName: categories[index].name,
                    imageURL:
                        'https://i.ytimg.com/vi/Hd3iBpUpgeg/maxresdefault.jpg');
              })),
    ));
  }
}
