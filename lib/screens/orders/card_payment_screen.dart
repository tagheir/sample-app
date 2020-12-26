import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardPaymentScreen extends StatefulWidget {
  final int orderId;
  CardPaymentScreen({this.orderId});
  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  App appBloc;
  //final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
  }

  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    appBloc = context.getAppBloc();
    var url = OrderPayment.OrderPaymentRedirecton.replaceAll(
        "{orderId}", widget.orderId.toString());

    var body = Column(
      children: [
        Expanded(
          child: InAppWebView(
            initialUrl: url,
            initialHeaders: {
              "Authorization": "Bearer " + appBloc.getRepo().token
            },
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
            )),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onLoadStop: (InAppWebViewController controller, String url) async {
              ////print("load stop Url == >" + url);
              if (url.contains("hc-action-complete")) {
                appBloc.add(OrderDetailViewEvent(
                    orderId: widget.orderId,
                    returnState: AppStateAuthenticated()));
              } else if (url.contains("cancel")) {
                appBloc.moveBack(context);
              }
            },
          ),
        ),
      ],
    );
    return LayoutScreen(
      scaffoldKey: scaffoldKey,
      addBackButton: true,
      showNavigationBar: false,
      childView: body,
      handleGesture: false,
      showFloatingButton: false,
    );
  }
}
