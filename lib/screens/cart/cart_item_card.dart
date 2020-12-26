import 'package:bluebellapp/models/shoppingCart_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/network_cache_image.dart';
import 'package:bluebellapp/screens/widgets/bottom_sheet_icon_button.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CartItemCard extends StatefulWidget {
  ShoppingCartItem item;
  final Function onEditClick;
  final Function onIncrement;
  final Function onDecrement;
  final Widget attributeWidget;
  final Function onDelClick;
  CartItemCard(
      {this.item,
      this.onDelClick,
      this.onEditClick,
      this.attributeWidget,
      this.onDecrement,
      this.onIncrement});

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  var attrVal;

  String getDropDownValue() {
    // var dropAttr = item?.productAttributes?.productAttribute
    //     ?.firstWhere(
    //         (a) => a.productAttributeName == AttributeType.DropdownList,
    //         orElse: () => null)
    //     ?.attributeValues;
    // if (dropAttr != null) {
    //   if (dropAttr?.attributeValue?.length != 0) {
    //     attrVal = dropAttr.attributeValue[0].name;
    //     return attrVal;
    //   }
    // }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //return Text(item?.product?.name ?? "");
    getDropDownValue();
    var list = List<Widget>();
    Widget delWidget;
    Widget quantityWidget;
    list.add(Expanded(flex: 2, child: _getImage()));
    if (widget.onDelClick != null) {
      delWidget = Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.only(
            top: 8,
            right: 0,
          ),
          child: _icon(context, Icons.delete,
              color: Colors.white,
              size: 18,
              onPressed: widget.onDelClick,
              backgroundColor: AppTheme.lightTheme.primaryColor),
        ),
      );
    }
    if (widget.onIncrement != null) {
      quantityWidget = Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BottomSheetIconButton(
              onPressed: () {
                if (widget.onDecrement != null) {
                  widget.onDecrement();
                }
              },
              width: 18,
              height: 18,
              size: 14,
              backgroundColor: AppTheme.lightTheme.primaryColor,
              icon: Icons.remove,
            ),
            Text(
              widget.item.quantity.toString(),
              style: TextConstants.H6.apply(color: LightColor.lightBlack),
            ),
            BottomSheetIconButton(
              onPressed: () {
                if (widget.onIncrement != null) {
                  widget.onIncrement();
                }
              },
              width: 18,
              height: 18,
              size: 14,
              backgroundColor: AppTheme.lightTheme.primaryColor,
              icon: Icons.add,
            ),
          ],
        ),
      );
    }
    var price = Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: quantityWidget != null
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Text(
                GeneralStrings.Currency +
                        widget.item.totalPrice.toInt().toString() ??
                    '',
                style: TextConstants.H7.apply(
                  color: LightColor.black,
                ),
              ).padding(EdgeInsets.only(top: 5, left: 10))
            ],
          ),
        ],
      ),
    );

    var editWidget = List<Widget>();
    editWidget.add(_getInfo());
    if (delWidget != null) {
      editWidget.add(delWidget);
    }
    var priceWidgets = List<Widget>();
    if (quantityWidget != null) {
      priceWidgets.add(quantityWidget);
    }
    if (price != null) {
      priceWidgets.add(price);
    }
    list.add(
      Expanded(
        flex: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: editWidget,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: priceWidgets),
          ],
        ),
      ),
    );

    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      ),
    );
  }

  Widget _getInfo() {
    var name = RichText(
      text: TextSpan(children: [
        TextSpan(
            text: widget.item.productName ?? '',
            style: TextConstants.H7.apply(
              color: LightColor.black,
            )),
        TextSpan(
          text: (widget.onIncrement == null
              ? "   x ${widget.item.quantity}"
              : ''),
          style: TextConstants.H7.apply(
            color: AppTheme.lightTheme.primaryColor,
          ),
        )
      ]),
    ).padding(EdgeInsets.only(right: 5));
    var attributes;
    if (widget.item.productAttributes != null) {
      attributes = widget.item.productAttributes
          .map((e) => Wrap(
                children: [
                  Text(
                    e.value,
                    style: TextConstants.H8.apply(color: LightColor.lightBlack),
                  )
                ],
              ))
          .toList();
    }
    var infoListWidgets = List<Widget>();
    infoListWidgets.add(name);
    if (attributes != null) {
      infoListWidgets.add(LayoutConstants.sizedBox5H);
      infoListWidgets.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: attributes,
      ));
    }
    return Expanded(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 5, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: infoListWidgets,
        ),
      ),
    );
  }

  Widget _getImage() {
    return ClipRRect(
      borderRadius: LayoutConstants.borderRadius,
      child: Container(
        height: 90,
        width: 90,
        child: NetworkCacheImage(
          altImageUrl: "https://placehold.it/130",
          imageUrl: widget.item.picture,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _icon(
    BuildContext context,
    IconData icon, {
    Color color = LightColor.iconColor,
    Color backgroundColor,
    double size,
    void Function() onPressed,
  }) {
    backgroundColor = backgroundColor ?? Theme.of(context).backgroundColor;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: LayoutConstants.borderRadius,
            color: backgroundColor,
            boxShadow: AppTheme.shadow),
        child: size == null
            ? Icon(icon, color: color)
            : Icon(icon, color: color, size: size),
      ),
    );
  }
}
