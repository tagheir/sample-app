import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/order_compact_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';

class MyOrderCard extends StatelessWidget {
  final OrderCompactDto obj;
  final AppState returnState;
  const MyOrderCard({this.obj, Key key, this.returnState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: InkWell(
        onTap: () {
          context.addEvent(OrderDetailViewEvent(
              orderId: obj.id,
              returnState: returnState != null ? returnState : null));
        },
        child: Container(
          height: 100,
          padding: AppTheme.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LayoutConstants.sizedBox5H,
                  Text(
                    "Order #" + obj.id.toString(),
                    style: TextConstants.H5,
                  ),
                  Text(
                    "Date: " + obj.createdOnUtc,
                    style: TextConstants.P7,
                  ),
                  LayoutConstants.sizedBox10H,
                  RichText(
                    text: TextSpan(
                      text: 'Order Status: ',
                      style: TextConstants.H7.apply(color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(
                          text: obj.orderStatus,
                          style: TextConstants.H7
                              .apply(color: AppTheme.lightTheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      obj.paymentMethodSystemName == "Cash"
                          ? Icon(Icons.money_off)
                          : Icon(Icons.payment),
                      LayoutConstants.sizedBox5W,
                      Text(obj?.paymentMethodSystemName ?? '',
                          textAlign: TextAlign.end, style: TextConstants.H6_5)
                    ],
                  ),
                  //.padding(LayoutConstants.edgeInsets8),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            GeneralStrings.Currency +
                                (obj.orderTotal.toInt()).toString(),
                            style: TextConstants.H6
                                .apply(color: AppTheme.lightTheme.primaryColor),
                          )
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
