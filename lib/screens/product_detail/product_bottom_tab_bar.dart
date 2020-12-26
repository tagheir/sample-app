import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/template_type.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/widgets/bottom_sheet_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductBottomTabBar extends StatelessWidget {
  bool isCartProduct;
  double price;
  Function onAddToCartButtonPressed;
  Function onBuyNowBtnPressed;
  TemplateType templateType;
  ProductBottomTabBar(
      {this.isCartProduct,
      this.price,
      this.onBuyNowBtnPressed,
      this.onAddToCartButtonPressed,
      this.templateType});

  String getButtonText() {
    if (isCartProduct == true &&
        templateType?.isMaintenancePackage() == false) {
      return 'Update Cart';
    } else if (isCartProduct == false &&
        templateType?.isMaintenancePackage() == false) {
      return 'Add To Cart';
    }
    // &&templateType?.isMaintenancePackage() == false
    else if (isCartProduct == false &&
        templateType?.isMaintenancePackage() == true) {
      return 'Buy Package';
    }
    return '';
  }

  bool showBuyNow() {
    if (isCartProduct == true &&
        templateType?.isMaintenancePackage() == false) {
      return false;
    } else if (isCartProduct == false &&
        templateType?.isMaintenancePackage() == false) {
      return true;
    }
    // &&templateType?.isMaintenancePackage() == false
    else if (isCartProduct == false &&
        templateType?.isMaintenancePackage() == true) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: LayoutConstants.borderRadius8,
            topRight: LayoutConstants.borderRadius8,
          ),
        ),
        child: getAddToCartRow()
            .padding(EdgeInsets.only(top: 10, left: 12, right: 6))
        // Padding(
        //   padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
        //   child: Column(
        //     children: <Widget>[
        //       // getProductQuantityRow(),
        //       ,
        //     ],
        //   ),
        // ),
        );
  }

  Row getAddToCartRow() {
    var pad = 6.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // BottomSheetIconButton(
        //   onPressed: () {},
        //   icon: Icons.favorite,
        // ).padding(EdgeInsets.only(right: pad)).expand(2),
        BottomSheetIconButton(
          onPressed: () {
            onAddToCartButtonPressed();
          },
          body: Text('Add To Cart', style: TextStyle(color: Colors.white)),
        ).padding(EdgeInsets.symmetric(horizontal: pad)).expand(4),
        BottomSheetIconButton(
          onPressed: () {
            if (onBuyNowBtnPressed == null) {
              onAddToCartButtonPressed();
            } else {
              onBuyNowBtnPressed();
            }
          },
          body: Text('Buy Now', style: TextStyle(color: Colors.white)),
          backgroundColor: LightColor.navy,
        ).padding(EdgeInsets.symmetric(horizontal: pad)).expand(4),
        // Expanded(
        //   flex: 3,
        //   child: Column(
        //     children: <Widget>[
        //       getTextButton(),
        //     ],
        //   ),
        // )
      ],
    );
  }

  Widget getTextButton() {
    return Container(
      height: 50,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Text(
              getButtonText(),
              style: TextConstants.P6.apply(color: Colors.white),
            ).expand(1),
          ],
        ),
        onPressed: () {
          onAddToCartButtonPressed();
        },
        color: LightColor.orange,
        shape: LayoutConstants.shapeBorderRadius8,
      ),
    );
  }
}
