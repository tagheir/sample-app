import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/checkout_model.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/loading_screen.dart';
import 'package:bluebellapp/screens/orders/checkout_screen.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custome_alert_dialog.dart';
import 'package:flutter/material.dart';

class CartCheckoutScreen extends StatefulWidget {
  @override
  _CartCheckoutScreenState createState() => _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AppScreenBloc appScreenBloc;
  App appBloc;
  CheckoutCartScreenData checkoutCartScreenData;
  bool isDataLoaded = false;
  bool isOrderPlaced;
  Function onError;
  CheckoutModel checkoutModel;
  bool dataInitialized = true;
  CustomProgressDialog pr;

  placeOrder(String billingAddress) async {
    print("=======billing address==== ");
    print(billingAddress);
    if (billingAddress.isEmpty || billingAddress == null) {
      CustomAlertDialog.showNew(
          cntxt: scaffoldKey.currentContext,
          text: 'Warning !' + '\nEnter address info');
    } else if (billingAddress != null &&
        checkoutModel.cartDto.shoppingCartItems.length >= 1) {
      appScreenBloc.add(
          AppScreenRequestEvent(function: checkoutCartScreenData.placeOrder));
    }
  }

  initializeData() {
    if (App.get().currentState.rebuild == null) {
      ////print("===rebuild null===");
      App.get().currentState.rebuild = () async {
        pr.showDialog();
        ////print("===rebuild null===");
        var data = (await context.getAppScreenBloc().screenData.getScreenData())
            .data as CheckoutModel;
        //print("===data received===");
        //print(data.billingAddress);
        setState(() {
          checkoutModel = data;
          pr.hideDialog();
        });
      };
    }
    if (checkoutModel == null) {
      checkoutModel = context.getAppScreenBloc().data;
    }
    appScreenBloc = context.getAppScreenBloc();
    checkoutCartScreenData = CheckoutCartScreenData(context.getAppBloc());
    appBloc = context.getAppBloc();
    appScreenBloc.onRequestResponseFunction = (data) {
      if (data > 0) {
        var events = List<AppEvent>();
        events.add(OrderDetailViewEvent(
          orderId: data,
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
    ////print("=====checkout screen rebuild=====");
    pr = CustomProgressDialog(context: context);
    initializeData();
    if (!dataInitialized) {
      return LoadingScreen();
    }
    return CheckoutPage(
      checkoutModel: checkoutModel,
      scaffoldKey: scaffoldKey,
      onPlaceOrder: placeOrder,
      isOrderPlaced: isOrderPlaced,
    );
  }
}
