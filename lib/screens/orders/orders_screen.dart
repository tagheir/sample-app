import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/order_compact_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/orders/order_card.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:flutter/material.dart';

class CustomerOrders extends StatefulWidget {
  final bool showTabBar;
  final AppState returnState;
  CustomerOrders({this.showTabBar, this.returnState});
  @override
  _CustomerOrdersState createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  List<OrderCompactDto> orderlist;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isInitialized = false;
  bool isDataLoaded = false;
  bool isLoading = false;
  int pageNo = 1;
  CustomerOrdersScreenData ordersScreenData;

  getOrders() {
    ordersScreenData.pageNo = pageNo;
    context
        .getAppScreenBloc()
        .add(AppScreenRequestEvent(function: ordersScreenData.getScreenData));
  }

  initialize() {
    if (!isInitialized) {
      orderlist = context.getAppScreenBloc().data;
      ordersScreenData = CustomerOrdersScreenData(context.getAppBloc());
      context.getAppScreenBloc().onRequestResponseFunction = (data) {
        if (data.length > 0) {
          setState(() {
            orderlist = orderlist + data;
            pageNo++;
          });
        } else {
          setState(() {
            isDataLoaded = true;
          });
        }
      };
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    var list = List<Widget>();
    list.add(_title());
    list.add(orderlist == null || orderlist.length == 0
        ? DataEmpty(message: GeneralStrings.NO_ORDERS)
        : Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (isDataLoaded == false &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  getOrders(); // start loading data
                }
                return null;
              },
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                children: orderlist
                    .map((order) => MyOrderCard(
                          obj: order,
                        ))
                    .toList(),
              ),
            ),
          ));

    return LayoutScreen(
      scaffoldKey: scaffoldKey,
      addBackButton: true,
      showNavigationBar: false,
      isAppScreenBloc: true,
      childView: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
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
              Text(GeneralStrings.MY, style: TextConstants.P5),
              Text(GeneralStrings.ORDERS, style: TextConstants.H4),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
