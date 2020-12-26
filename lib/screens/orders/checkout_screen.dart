import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/address_enum.dart';
import 'package:bluebellapp/models/checkout_model.dart';
import 'package:bluebellapp/models/shoppingCart_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/cart/cart_item_card.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/fixed_bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckoutPage extends StatefulWidget {
  CheckoutModel checkoutModel;
  Function(String) onPlaceOrder;
  bool isOrderPlaced;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isDataLoaded;

  CheckoutPage({
    @required this.checkoutModel,
    this.scaffoldKey,
    this.isOrderPlaced,
    @required this.onPlaceOrder,
    this.isDataLoaded = false,
  });
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  App appBloc;
  bool dataInitialized = false;

  initializeData() {
    appBloc = context.getAppBloc();
  }

  placeOrder() {
    widget.onPlaceOrder(widget.checkoutModel.billingAddress);
  }

  Widget _title() {
    return Container(
      //margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Checkout', style: TextConstants.H4),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeData();
    ////print("=====checkout page rebuild=====");
    var body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: <Widget>[
          _title(),
          LayoutConstants.sizedBox30H,
          itemsCard(context),
          LayoutConstants.sizedBox10H,
          getPriceCard(context),
          LayoutConstants.sizedBox10H,
          getAddressInfo(context, true, widget.checkoutModel.billingAddress),
          LayoutConstants.sizedBox10H,
          getAddressInfo(context, false, widget.checkoutModel.shippingAddress),
          getTermsCard(context),
          LayoutConstants.sizedBox40H,
        ],
      ),
    );
    return LayoutScreen(
      isAppScreenBloc: true,
      childView: body,
      showNavigationBar: false,
      scaffoldKey: widget.scaffoldKey,
      addBackButton: true,
      showFloatingButton: false,
      bottomBar: FixedBottomButton(
        onTap: placeOrder,
        text: "Proceed To Payment",
      ),
    );
  }

  Padding getTermsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 90.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'By completing the order, I hereby accepts to the terms and condition',
                  style: TextConstants.H8.apply(color: LightColor.lightBlack)),
            ],
          ),
        ),
      ),
    );
  }

  // Container getPaymentInfoCard(BuildContext context) {
  //   return Container(
  //     height: 120,
  //     width: MediaQuery.of(context).size.width,
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text('Payment Method',
  //                 style: TextConstants.H6.apply(color: LightColor.lightBlack)),
  //             LayoutConstants.sizedBox20H,
  //             Text('CASH',
  //                 style: TextConstants.H7.apply(color: LightColor.orange))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Card getAddressInfo(
      BuildContext context, bool isBillingAddress, String address) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    isBillingAddress == true
                        ? 'Billing Address'
                        : 'Shipping Address',
                    style:
                        TextConstants.H7.apply(color: LightColor.lightBlack)),
                Text(
                    isBillingAddress == true
                        ? 'Choose Billing Address'
                        : 'Choose Shipping Address',
                    style:
                        TextConstants.H8.apply(color: LightColor.lightBlack)),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  appBloc.add(CustomerAddressesViewEvent(
                      addressType: isBillingAddress == true
                          ? AddressType.BillingAddress
                          : AddressType.ShippingAddress));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LayoutConstants.sizedBox5H,
                          Text(
                            address == null ? "Choose Address" : address,
                            style: TextConstants.H7.apply(
                              color: LightColor.black,
                            ),
                          ),
                          LayoutConstants.sizedBox15H,
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Card getPriceCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Subtotal',
                    style:
                        TextConstants.H6.apply(color: LightColor.lightBlack)),
                Text(
                    GeneralStrings.Currency +
                            widget?.checkoutModel?.cartDto?.totalCost
                                ?.toInt()
                                ?.toString() ??
                        "0",
                    style: TextConstants.H7.apply(color: LightColor.black)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Delivery Fee',
                    style:
                        TextConstants.H7.apply(color: LightColor.lightBlack)),
                Text(GeneralStrings.Currency + '0',
                    style: TextConstants.H6.apply(color: LightColor.black)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total',
                    style:
                        TextConstants.H6.apply(color: LightColor.lightBlack)),
                Text(
                    GeneralStrings.Currency +
                            widget?.checkoutModel?.cartDto?.totalCost
                                ?.toInt()
                                ?.toString() ??
                        "0",
                    style: TextConstants.H6.apply(color: LightColor.black)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getItemCardWidget(ShoppingCartItem cartItem) {
    // getCartItemAttributes(cartItem);
    Widget attributeWidget;
    if (attributeWidget != null) {
      attributeWidget = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.calendar_today, color: LightColor.orange, size: 15),
          SizedBox(
            width: 5,
          ),
          Text(
            '',
            style: TextConstants.H8.apply(
              color: LightColor.black,
            ),
          )
        ],
      );
    }
    return CartItemCard(
      item: cartItem,
      attributeWidget: attributeWidget,
    );
  }

  Widget itemsCard(BuildContext context) {
    return Column(
        children: widget.checkoutModel.cartDto.shoppingCartItems
            .map((x) => getItemCardWidget(x))
            .toList());
  }
}
