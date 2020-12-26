// import 'package:bluebellapp/models/order_dto.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
// import 'package:bluebellapp/resources/theme_scheme.dart';
// import 'package:bluebellapp/screens/home/junaid/myordersdetails.dart';
// import 'package:flutter/material.dart';

// class MyOrderCard extends StatelessWidget {
//   final OrderDto obj;
//   const MyOrderCard({
//     this.obj,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8,
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (BuildContext context) => MyOrdersDetails()));
//         },
//         child: Container(
//           height: 105,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     LayoutConstants.sizedBox5H,
//                     Wrap(
//                       children: <Widget>[
//                         Text(
//                           "Order ID: ",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           obj.id.toString(),
//                           style: TextStyle(fontSize: 18),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Wrap(
//                       children: <Widget>[
//                         Text(
//                           "Date: ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: Colors.grey[500]),
//                         ),
//                         Text(
//                           obj.paidDateUtc,
//                           style: TextStyle(color: Colors.grey[500]),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
// //                        Text("Order Status:Completed"),
//                     RichText(
//                       text: TextSpan(
//                         text: 'Order Status ',
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: obj.orderStatus.toString(),
//                             style: TextStyle(
//                                 //fontWeight: FontWeight.bold,
//                                 color: ThemeScheme.lightTheme.primaryColor),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     )
//                   ],
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           height: 25,
//                           child: Image.network(
//                               'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQWjS0hD66RXw1AhcZL2SK2prpk9Cl0hMeMbRtDmlQlYZ0qfXb6'),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           obj.paymentMethodSystemName,
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.only(bottom: 5.0),
//                       child: Row(
//                         children: <Widget>[
//                           Text(
//                             "Price: ",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: ThemeScheme.lightTheme.primaryColor),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 3.0),
//                             child: Text(
//                               obj.currencyRate.toString(),
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: ThemeScheme.lightTheme.primaryColor),
//                             ),
//                           )
//                         ],
//                       )),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
