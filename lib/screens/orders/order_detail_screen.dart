import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/attribute_dto.dart';
import 'package:bluebellapp/models/order_detail_dto.dart';
import 'package:bluebellapp/models/order_item_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/repos/cart_repo.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/network_cache_image.dart';
import 'package:bluebellapp/screens/widgets/fixed_bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;
  final AppState returnState;
  OrderDetailScreen({this.orderId, this.returnState});
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isDataLoaded = false;
  OrderDetailDto orderDetail;
  App appBloc;
  CartRepository cartRepository;
  ProductAttribute dropAttr;
  ProductDto product = ProductDto();
  bool productLoaded = false;
  var attrVal;
  var dateVal;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _title() {
    return Container(
      margin: AppTheme.h2Padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Order #' + orderDetail?.id?.toString() ?? '',
                  style: TextConstants.H4),
            ],
          ),
        ],
      ),
    );
  }

  Widget getInfoRow({Widget leading, Widget trailing}) {
    var childs = List<Widget>();
    if (leading != null) {
      childs.add(Expanded(
        flex: 1,
        child: leading,
      ));
    }
    if (trailing != null) {
      childs.add(Expanded(
        flex: 1,
        child: trailing,
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childs),
    );
  }

  Widget orderBasicDetailCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getInfoRow(
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                Icon(
                  Icons.settings,
                  size: 20,
                  color: LightColor.orange,
                ),
                Text(orderDetail.orderStatus,
                    style: TextConstants.H7.apply(color: LightColor.black)),
              ])),
          getInfoRow(
              leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.calendar_today, size: 18),
              SizedBox(
                width: 3,
              ),
              Text(orderDetail.createdOnUtc,
                  style: TextConstants.H7.apply(color: LightColor.black)),
            ],
          )),
          SizedBox(
            height: 15,
          ),
          getInfoRow(
            leading: Text('Billing Address',
                style: TextConstants.H7.apply(color: LightColor.lightBlack)),
          ),
          getInfoRow(
            leading: Text(orderDetail.billingAddress ?? "",
                style: TextConstants.H6.apply(color: LightColor.black)),
          ),
          SizedBox(
            height: 15,
          ),
          getInfoRow(
            leading: Text('Shipping Address',
                style: TextConstants.H7.apply(color: LightColor.lightBlack)),
          ),
          getInfoRow(
            leading: Text(orderDetail.shippingAddress ?? "",
                style: TextConstants.H6.apply(color: LightColor.black)),
          ),
          SizedBox(
            height: 15,
          ),
          getInfoRow(
            leading: Text('Payment Method',
                style: TextConstants.H7.apply(color: LightColor.lightBlack)),
          ),
          getInfoRow(
              leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              orderDetail.paymentMethodSystemName == "Cash"
                  ? Icon(Icons.money_off, size: 18)
                  : Icon(Icons.payment, size: 18),
              SizedBox(
                width: 3,
              ),
              Text(orderDetail.paymentMethodSystemName ?? '',
                  style: TextConstants.H6.apply(color: LightColor.black)),
            ],
          )),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget getOrderItemRow(OrderItem orderItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _getImage(orderItem.picture),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 5, bottom: 8),
              child: _getInfo(orderItem),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getInfo(OrderItem orderItem) {
    List<Widget> attributesWidget;
    if (orderItem.productAttributes.length > 0) {
      attributesWidget = orderItem.productAttributes
          .map((e) => Wrap(children: [
                Text(
                  e.value ?? '',
                  style: TextConstants.H7.apply(
                    color: LightColor.darkGrey,
                  ),
                ),
              ]))
          .toList();
    }

    return Container(
      margin: EdgeInsets.only(top: 10, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Text(
                orderItem.productName ?? '',
                style: TextConstants.H7.apply(
                  color: LightColor.black,
                ),
              ),
              LayoutConstants.sizedBox5H,
            ],
          ),
          attributesWidget != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: attributesWidget,
                )
              : Text(''),
          Wrap(
            children: <Widget>[
              LayoutConstants.sizedBox5H,
              Text(
                GeneralStrings.Currency + orderItem.price?.toInt().toString() ??
                    '0.0',
                style: TextConstants.H7.apply(
                  color: LightColor.orange,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _getImage(String pictureThumb) {
    return ClipRRect(
      borderRadius: LayoutConstants.borderRadius,
      child: NetworkCacheImage(
        altImageUrl: "https://placehold.it/130",
        imageUrl: pictureThumb ?? "https://placehold.it/130",
        width: 110.0,
        height: 90.0,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget getCartItemRows() {
    var cartItemsWidgets = List<Widget>();
    if (orderDetail.orderItems.length > 0) {
      cartItemsWidgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Order Items',
            style: TextConstants.H6.apply(color: LightColor.lightBlack)),
      ));

      orderDetail.orderItems.forEach((o) async {
        cartItemsWidgets.add(getOrderItemRow(o));
      });
    }

    return cartItemsWidgets.length > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cartItemsWidgets)
        : Text('');
  }

  Widget getCartItemsCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
      child: Card(child: getCartItemRows()),
    );
  }

  Widget orderPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getInfoRow(
                leading: Text('Subtotal',
                    style:
                        TextConstants.H6.apply(color: LightColor.lightBlack)),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        GeneralStrings.Currency +
                            orderDetail?.orderTotal?.toInt().toString(),
                        style: TextConstants.H7.apply(color: LightColor.black)),
                  ],
                ),
              ),
              // getInfoRow(
              //   leading: Text('Tax',
              //       style:
              //           TextConstants.H7.apply(color: LightColor.lightBlack)),
              //   trailing: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: <Widget>[
              //       Text(
              //           GeneralStrings.Currency +
              //               (orderDetail.orderTotal).toStringAsFixed(2),
              //           style: TextConstants.H7.apply(color: LightColor.black)),
              //     ],
              //   ),
              // ),
              getInfoRow(
                leading: Text('Total',
                    style:
                        TextConstants.H6.apply(color: LightColor.lightBlack)),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        GeneralStrings.Currency +
                            (orderDetail.orderTotal.toInt()).toString(),
                        style:
                            TextConstants.H5.apply(color: LightColor.orange)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    appBloc = context.getAppBloc();

    if (appBloc.currentState != null &&
        appBloc.currentState is OrderDetailViewState) {
      var state = appBloc.currentState as OrderDetailViewState;
      // if (state.moveToPayment == true) {
      //   appBloc.add(
      //     PaymentMethodScreenViewEvent(
      //       orderId: state.orderId,
      //     ),
      //   );
      // }
    }
    if (orderDetail == null) {
      orderDetail = context.getAppScreenBloc().data;
    }
    var body = List<Widget>();

    body.add(_title());
    body.add(orderBasicDetailCard());
    body.add(getCartItemsCard());
    body.add(orderPriceInfo());
    body.add(LayoutConstants.sizedBox30H);

    return LayoutScreen(
      addBackButton: true,
      showNavigationBar: false,
      scaffoldKey: scaffoldKey,
      returnState: AppStateAuthenticated(),
      childView: Container(child: ListView(children: body)),
      showFloatingButton: false,
      bottomBar: orderDetail.paymentStatus == "Pending"
          //&&orderDetail.paymentMethodSystemName == "Card"
          // PaymentMethodScreenViewEvent(
          //           orderId: orderDetail.id,
          //         ),
          ? FixedBottomButton(
              onTap: () {
                appBloc
                    .add(CardPaymentScreenViewEvent(orderId: orderDetail.id));
              },
              text: "Pay Now",
            )
          : null,
    );
  }
}
