import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/network_cache_image.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/services/required_length_text_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCompactView extends StatelessWidget {
  final ProductDto product;
  final double height;
  final double width;
  Widget imageContainer;
  BuildContext context;
  int rowCount;
  ProductCompactView({Key key, this.product, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    imageContainer = ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        width: this.width,
        height: this.width,
        child: NetworkCacheImage(
          altImageUrl:
              "https://placehold.it/" + (this.height * 0.60).toString(),
          fit: BoxFit.fill,
          imageUrl: product.pictureThumb,
        ),
      ),
    );
    return GestureDetector(
        onTap: () {
          context.addEvent(ProductDetailViewEvent(
              seName: product.seName, isCardProduct: false));
        },
        child: Container(
          height: this.height,
          width: this.width,
          decoration: LayoutConstants.boxDecoration,
          child: ClipRRect(
            borderRadius: BorderRadius.all(LayoutConstants.borderRadius4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imageContainer,
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          GetTextString.getRequiredLengthString(
                              text: product.name, requiredLength: 23),
                          textAlign: TextAlign.left,
                          style: TextConstants.H8,
                        ),
                        product?.price == null || product?.price == 0
                            ? Text('')
                            : Text(
                                    GeneralStrings.Currency +
                                        product?.price.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextConstants.CPH8)
                                .padding(EdgeInsets.only(top: 5)),
                      ],
                    ).padding(
                      EdgeInsets.only(left: 5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
