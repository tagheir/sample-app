import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/payment_method_type.dart';
import 'package:bluebellapp/screens/cardPayement_screen.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/widgets/fixed_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:bluebellapp/resources/themes/theme.dart';

class PaymentMethodScreen extends StatefulWidget {
  final int orderId;
  PaymentMethodScreen({this.orderId});
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedRadio;
  int selectedRadioTile;
  App appBloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CheckoutCartScreenData checkoutCartScreenData;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  initialize() {
    appBloc = context.getAppBloc();
    checkoutCartScreenData = CheckoutCartScreenData(appBloc);
    context.getAppScreenBloc().onRequestResponseFunction = (data) {
      if (data == true) {
        // appBloc.add(OrderDetailViewEvent(
        //     orderId: widget.orderId, returnState: AppStateAuthenticated()));
        appBloc.moveBack(context);
      }
    };
  }

  onTap() {
    if (selectedRadioTile == 1) {
      checkoutCartScreenData.orderId = widget.orderId;
      checkoutCartScreenData.paymentMethod =
          PaymentMethodType.CashOnDelivery.index + 1;
      context.getAppScreenBloc().add(
            AppScreenRequestEvent(
                function: checkoutCartScreenData.upDateOrderPaymentMethod),
          );
    } else if (selectedRadioTile == 2) {
      appBloc.add(CardPaymentScreenViewEvent(orderId: widget.orderId));
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    var body = getBody(context);
    return LayoutScreen(
      scaffoldKey: scaffoldKey,
      childView: body,
      addBackButton: true,
      showNavigationBar: false,
      returnState: CartItemsViewState(),
      isAppScreenBloc: true,
      bottomBar: FixedBottomButton(
        onTap: () {
          onTap();
        },
        text: "Proceed",
      ),
    );
  }

  Column getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title(),
        InkWell(
          onTap: () {},
          child: Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text('By Cash'),
                    onChanged: (val) {
                      setSelectedRadioTile(val);
                    },
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset('assets/images/cash.png'),
                    ))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CardPayment()));
            //TODO
          },
          child: Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    title: Text('Credit or debit card'),
                    onChanged: (val) {
                      ////print('Radia tile pressed  $val');
                      setSelectedRadioTile(val);
                    },
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset('assets/images/card.jpg'),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Choose', style: TextConstants.P5),
              Text('Payment Method', style: TextConstants.H4),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
