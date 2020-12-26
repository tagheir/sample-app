// import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
// import 'package:bluebellapp/resources/themes/light_color.dart';
// import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/text_widgets/general-text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bluebellapp/models/customer_dto.dart';

// class AppDrawer extends StatefulWidget {
//   @override
//   _AppDrawerState createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   AppBloc appBloc;
//   CustomerDto myInfo;
//   List<Widget> drawerWidgets = List<Widget>();
//   //int cartCount;
//   //int orderCount;
//   var isUserLoggedIn;

//   @override
//   Widget build(BuildContext context) {
//     appBloc = context.getAppBloc();
//     // ////print("==========widget reset=====");
//     isUserLoggedIn = appBloc.isUserLoggedIn;
//     if (isUserLoggedIn == true && myInfo == null) {
//       appBloc.getRepo().getUserRepository().getProfileInfo().then((data) {
//         if (data != null) {
//           setState(() {
//             myInfo = data;
//           });
//         }
//       });
//     }
//     // return Column(
//     //   mainAxisSize: MainAxisSize.min,
//     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //   crossAxisAlignment: CrossAxisAlignment.start,
//     //   children: <Widget>[

//     //   ],
//     // );
//     return Column(
//       // mainAxisSize: MainAxisSize.min,
//       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//       // crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         isUserLoggedIn == true
//             ? getAuthenticatedDrawer()
//             : getUnAuthenticatedDrawer(),
//         Expanded(
//           child: isUserLoggedIn == true
//               ? MediaQuery.removePadding(
//                     removeTop: true,
//                     context: context,
//                     child: ListView(shrinkWrap: true, children: [
//                     // getDrawerListTile(
//                     //     context: context,
//                     //     title: 'Home',
//                     //     icon: Icons.home,
//                     //     onTap: () {
//                     //       //Navigator.pop(context);
//                     //     }),
//                     getDrawerListTile(
//                         context: context,
//                         title: 'My Profile',
//                         icon: Icons.person,
//                         onTap: () {
//                           //Navigator.pop(context);
//                           appBloc.add(CustomerProfileViewEvent());
//                         }),
//                     // getDrawerListTile(
//                     //     context: context,
//                     //     title: 'My Addresses',
//                     //     icon: Icons.person,
//                     //     onTap: () {
//                     //       //Navigator.pop(context);
//                     //       appBloc.add(CustomerAddressesViewEvent());
//                     //     }),
//                     // getDrawerListTile(
//                     //     context: context,
//                     //     title: 'My Wishlist',
//                     //     icon: Icons.favorite,
//                     //     itemCount: 4,
//                     //     onTap: () {
//                     //       //Navigator.pop(context);
//                     //       // appBloc.add(CustomerProfileViewEvent());
//                     //     }),
//                     getDrawerListTile(
//                         context: context,
//                         title: 'My Cart',
//                         icon: Icons.shopping_cart,
//                         //itemCount: cartCount == null ? 0 : cartCount,
//                         onTap: () {
//                           //Navigator.pop(context);
//                           appBloc.add(CartItemsViewEvent());
//                         }),
//                     getDrawerListTile(
//                         context: context,
//                         title: 'My Orders',
//                         icon: Icons.shop,
//                        // itemCount: orderCount == null ? 0 : orderCount,
//                         onTap: () {
//                           //Navigator.pop(context);
//                           appBloc.add(OrdersViewEvent());
//                         }),
//                     Divider(color: LightColor.darkGrey),
//                     // getDrawerListTile(
//                     //     context: context,
//                     //     title: 'Settings',
//                     //     icon: Icons.settings,
//                     //     onTap: () {
//                     //       //Navigator.pop(context);
//                     //       //  appBloc.add(CartItemsViewEvent());
//                     //     }),
//                     getDrawerListTile(
//                         context: context,
//                         title: 'Logout',
//                         icon: Icons.exit_to_app,
//                         onTap: () {
//                           //Navigator.pop(context);
//                           appBloc.add(LoggedOut());
//                         }),
//                   ]),
//               ): Text('')
//               // : MediaQuery.removePadding(
//               //       context: context,
//               //       removeTop: true,
//               //       child: ListView(shrinkWrap: true, children: [
//               //       getDrawerListTile(
//               //           context: context,
//               //           title: 'Home',
//               //           icon: Icons.home,
//               //           onTap: () {
//               //             //Navigator.pop(context);
//               //           }),
//               //       //Divider();
//               //       getDrawerListTile(
//               //           context: context,
//               //           title: 'Settings',
//               //           icon: Icons.settings,
//               //           onTap: () {
//               //             //Navigator.pop(context);
//               //           }),
//               //     ]),
//               // ),
//         ),
//       ],
//     );
//   }

//   ListTile getDrawerListTile(
//       {BuildContext context,
//       String title,
//       Function onTap,
//       int itemCount,
//       IconData icon}) {
//     return ListTile(
//       leading: Icon(icon, color: Theme.of(context).iconTheme.color),
//       title: Text(title),
//       trailing: itemCount != null
//           ? Container(
//               padding: const EdgeInsets.all(10.0),
//               decoration: new BoxDecoration(
//                 shape: BoxShape.circle,
//                 //color: Theme.of(context).primaryColor,
//               ),
//               child: Text(itemCount.toString(),
//                   style: TextStyle(color: Colors.white, fontSize: 10.0)),
//             )
//           : null,
//       onTap: () {
//         onTap();
//       },
//     );
//   }

//   getAuthenticatedDrawer() {
//     return myInfo == null
//         ? UserAccountsDrawerHeader(
//             decoration: BoxDecoration(),
//             currentAccountPicture: ContainerCacheImage(
//               altImageUrl: "https://placehold.it/200",
//               imageUrl: "https://placehold.it/200",
//               borderRadius: BorderRadius.circular(50.0),
//             ),
//             accountEmail: Text(''),
//             accountName: Text(''),
//           )
//         : UserAccountsDrawerHeader(
//             decoration: BoxDecoration(),
//             currentAccountPicture: ContainerCacheImage(
//               altImageUrl: "https://placehold.it/200",
//               imageUrl: myInfo?.imageUrl,
//               borderRadius: BorderRadius.circular(50.0),
//             ),
//             accountName: GeneralText(
//                 (myInfo?.firstName ?? "") + " " + (myInfo?.lastName ?? ""),
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500),
//             accountEmail: GeneralText(
//               myInfo?.email,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           );
//   }

//   UserAccountsDrawerHeader getUnAuthenticatedDrawer() {
//     return UserAccountsDrawerHeader(
//       decoration: BoxDecoration(),
//       currentAccountPicture: ContainerCacheImage(
//         altImageUrl: "https://placehold.it/200",
//         imageUrl: "https://placehold.it/200",
//         borderRadius: BorderRadius.circular(50.0),
//       ),
//       accountEmail: GestureDetector(
//           onTap: () {
//             appBloc.add(LoginScreenEvent());
//           },
//           child: Text(
//             'Log In / Create Account',
//             style: TextConstants.H6,
//             // TextStyle(
//             //     color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
//           )),
//       accountName: GeneralText(
//         "Guest",
//         color: Colors.black,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }
// }
