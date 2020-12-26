import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/bloc/product_bloc/product_bloc.dart';
import 'package:bluebellapp/models/addToCart_dto.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/checkout_model.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/models/shoppingCart_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/orders/checkout_screen.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custome_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bluebellapp/models/product_attribute_dto.dart';

class DirectCheckoutScreen extends StatefulWidget {
  AddToCartDto addToCartDto;
  ProductDto product;
  DirectCheckoutScreen({@required this.addToCartDto, @required this.product});

  @override
  _DirectCheckoutScreenState createState() => _DirectCheckoutScreenState();
}

class _DirectCheckoutScreenState extends State<DirectCheckoutScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDataLoaded = false;
  bool isOrderPlaced;
  Function onError;
  ProductBloc productBloc;
  App appBloc;
  ShoppingCartDto cartDto;
  List<ShoppingCartItem> cartItems = List<ShoppingCartItem>();
  ProductDto product = ProductDto();
  CustomProgressDialog pr;
  AppScreenBloc appScreenBloc;
  CheckoutCartScreenData checkoutCartScreenData;
  CheckoutModel checkoutModel;
  bool dataInitialized = true;

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  getCartItems() {
    var productAttribute = widget.addToCartDto.directOrderProductAttribute;
    product.pictureThumb = productAttribute.pictureThumb;
    product.name = productAttribute.name;
    var productAttr = List<ProductCompactAttribute>();
    if (productAttribute.dateAttributeValue != null) {
      productAttr.add(ProductCompactAttribute(
          name: "", value: productAttribute.dateAttributeValue));
    }
    if (productAttribute.dropDownAttributeValue != null) {
      productAttr.add(ProductCompactAttribute(
          name: "", value: productAttribute.dropDownAttributeValue));
    }
    cartDto = ShoppingCartDto(
        totalQuantity: 1,
        totalCost: productAttribute.price,
        shoppingCartItems: cartItems);
    setState(() {
      cartDto.shoppingCartItems.add(ShoppingCartItem(
          productId: widget.addToCartDto.productId,
          picture: productAttribute.pictureThumb,
          productName: productAttribute.name,
          totalPrice: productAttribute.price,
          quantity: productAttribute.quantity,
          productAttributes: productAttr));
      isDataLoaded = true;
    });
  }

  placeOrder(String billingAddress) async {
    if (billingAddress == null) {
      CustomAlertDialog.showNew(
          cntxt: scaffoldKey.currentContext,
          text: 'Warning !' + '\nEnter address info');
    } else if (billingAddress != null &&
        checkoutModel.cartDto.shoppingCartItems.length >= 1) {
      checkoutCartScreenData.addToCartDto = widget.addToCartDto;
      appScreenBloc.add(AppScreenRequestEvent(
          function: checkoutCartScreenData.placeDirectOrder));
    }
  }

  initializeData() {
    if (App.get().currentState.rebuild == null) {
      App.get().currentState.rebuild = () async {
        pr.showDialog();
        var data = (await context.getAppScreenBloc().screenData.getScreenData())
            .data as CheckoutModel;
        setState(() {
          checkoutModel = data;
          pr.hideDialog();
        });
      };
    }
    if (cartDto?.shoppingCartItems == null) {
      getCartItems();
    }
    if (checkoutModel == null) {
      checkoutModel = context.getAppScreenBloc().data;
      checkoutModel.cartDto = cartDto;
    }
    appScreenBloc = context.getAppScreenBloc();
    checkoutCartScreenData = CheckoutCartScreenData(context.getAppBloc());
    appBloc = context.getAppBloc();
    appScreenBloc.onRequestResponseFunction = (data) {
      //print(data.orderId);
      if (data.orderId > 0) {
        var events = List<AppEvent>();
        events.add(OrderDetailViewEvent(
          orderId: data.orderId,
          moveToPayment: true,
          returnState: AppStateAuthenticated(),
        ));

        events.add(
          PaymentMethodScreenViewEvent(
            orderId: data,
          ),
        );
        context.addEvents(events);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.addToCartDto.productId);
    appBloc = context.getAppBloc();
    pr = CustomProgressDialog(context: context);
    initializeData();
    //productBloc = context.getProductBloc();
    return CheckoutPage(
      checkoutModel: checkoutModel,
      scaffoldKey: scaffoldKey,
      onPlaceOrder: placeOrder,
      isDataLoaded: isDataLoaded,
      isOrderPlaced: isOrderPlaced,
    );
  }
}
