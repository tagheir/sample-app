import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/addToCart_dto.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/shoppingCart_dto.dart';
import 'package:bluebellapp/models/update_cart_dto.dart';
import 'package:bluebellapp/repos/cart_repo.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/cart/cart_item_card.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/fixed_bottom_button.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemsScreen extends StatefulWidget {
  @override
  _CartItemsScreenState createState() => _CartItemsScreenState();
}

class _CartItemsScreenState extends State<CartItemsScreen> {
  ShoppingCartDto cart = ShoppingCartDto();
  AddToCartDto addToCartDto = AddToCartDto();
  UpdateCartDto updateCartDto = UpdateCartDto();
  CartRepository cartRepo;
  CustomProgressDialog pr;
  bool isDataLoaded = false;
  CartItemsScreenData screenData;
  AppScreenBloc appScreenBloc;
  CartOperation cartOperationSelected;
  ShoppingCartItem cartItemSelected;
  double price = 0;
  bool dataInitialized = false;
  var attrVal;
  var productPrice;
  var appBloc;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Colors.red,
    ));
  }

  onUpdateCart(UpdateCartDto cartDto) {
    if (cartDto.shoppingCart != null && cartDto.success) {
      setState(() {
        cart = cartDto.shoppingCart;
      });
    } else if (!cartDto.success) {
      showInSnackBar(cartDto.message);
    }
  }

  onCartItemRemove(ShoppingCartDto cartDto) {
    if (cartDto != null) {
      setState(() {
        cart = cartDto;
      });
    }
  }

  onIncrement() {
    addToCartDto.cartItemId = cartItemSelected.id;
    addToCartDto.productId = cartItemSelected.productId;
    addToCartDto.quantity = cartItemSelected.quantity += 1;
    screenData.cartDto = addToCartDto;
  }

  onDecrement() {
    if (cartItemSelected.quantity > 1) {
      addToCartDto.cartItemId = cartItemSelected.id;
      addToCartDto.productId = cartItemSelected.productId;
      addToCartDto.quantity = cartItemSelected.quantity -= 1;
      screenData.cartDto = addToCartDto;
    }
  }

  upDateCart(ShoppingCartItem cartItem, CartOperation cartOperation) {
    cartItemSelected = cartItem;
    if (cartOperation == CartOperation.INCREMENT_CART_ITEM) {
      onIncrement();
    }
    if (cartOperation == CartOperation.DECREMENT_CART_ITEM) {
      onDecrement();
    }
    if (cartOperation == CartOperation.INCREMENT_CART_ITEM ||
        cartOperation == CartOperation.DECREMENT_CART_ITEM) {
      appScreenBloc.onRequestResponseFunction = (data) {
        onUpdateCart(data);
      };
      appScreenBloc.add(AppScreenRequestEvent(function: screenData.upDateCart));
    } else if (cartOperation == CartOperation.REMOVE_CART_ITEM) {
      screenData.cartItemId = cartItem.id;
      appScreenBloc.onRequestResponseFunction = (data) {
        onCartItemRemove(data);
      };
      appScreenBloc
          .add(AppScreenRequestEvent(function: screenData.removeCartItem));
    }
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Shopping', style: TextConstants.P5),
              Text('Cart', style: TextConstants.H4),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _cartItems() {
    if (cart?.shoppingCartItems == null || cart.shoppingCartItems.length == 0) {
      return Column(
        children: <Widget>[],
      );
    }

    return Column(
        children: cart.shoppingCartItems
            .map(
              (x) => CartItemCard(
                item: x,
                onDelClick: () {
                  upDateCart(x, CartOperation.REMOVE_CART_ITEM);
                },
                onIncrement: () {
                  upDateCart(x, CartOperation.INCREMENT_CART_ITEM);
                },
                onDecrement: () {
                  upDateCart(x, CartOperation.DECREMENT_CART_ITEM);
                },
                onEditClick: () {
                  (context).addEvent(
                    ProductDetailViewEvent(
                      seName: x.seName,
                      isCardProduct: true,
                      cartItemId: x.id,
                    ),
                  );
                },
              ),
            )
            .toList());
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${cart.totalQuantity} Items',
          style: TextConstants.H6.apply(color: LightColor.grey),
        ),
        Text(
          'Rs  ${cart.totalCost.toInt().toString()}',
          style: TextConstants.H4,
        ),
      ],
    ).padding(AppTheme.padding);
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          context.addEvent(CartCheckoutViewEvent());
        },
        shape: LayoutConstants.shapeBorderRadius8,
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: Text(
            'Checkout',
            style: TextStyle(
              color: LightColor.background,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }

  initialize() {
    if (!dataInitialized) {
      if (pr == null) {
        pr = CustomProgressDialog(context: context);
      }
      //print("h1");
      if (screenData == null) {
        cart = context.getAppScreenBloc().data;
        //print(cart.shoppingCartItems.length);
        //print("h2");
        screenData =
            context.getAppScreenBloc().screenData as CartItemsScreenData;
        //print("h3");
        appScreenBloc = context.getAppScreenBloc();
      }
      dataInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    var body = List<Widget>();
    body.add(_title());
    if (cart == null ||
        cart.shoppingCartItems == null ||
        cart.shoppingCartItems.length == 0) {
      body.add(
        DataEmpty(
          message: 'Cart is Empty',
        ),
      );
    } else {
      body.add(_cartItems());
      body.add(Divider(thickness: 1, height: 70));
      body.add(_price());
      body.add(LayoutConstants.sizedBox100H);
    }

    return LayoutScreen(
      isAppScreenBloc: true,
      bottomBarType: BottomBarType.Cart,
      scaffoldKey: scaffoldKey,
      childView: ListView(
        children: body,
      ),
      addBackButton: true,
      showNavigationBar: false,
      showFloatingButton: false,
      showHeaderProfileIcon: true,
      showHeaderHomeIcon: true,
      bottomBar: cart?.shoppingCartItems != null
          ? cart.shoppingCartItems.length > 0
              ? FixedBottomButton(
                  onTap: () => context.addEvent(
                    CartCheckoutViewEvent(),
                  ),
                  text: "Check Out",
                )
              : null
          : null,
    );
  }
}
