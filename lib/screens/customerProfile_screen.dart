import 'package:bluebellapp/models/address_enum.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/screens/address_screen.dart';
import 'package:bluebellapp/screens/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/helper_widgets/button_widgets/tab_back_button.dart';
import 'widgets/helper_widgets/text_widgets/general-text.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';

class CustomerProfile extends StatefulWidget {
  final int tabIndex;
  CustomerProfile({this.tabIndex}) {
    ////print(tabIndex);
  }
  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  List<Widget> containers = [
    //ViewAndEditProfile(),
    CustomerAddress(
      showTabBar: false,
      addressType: AddressType.None,
    ),
    CustomerOrders(
      showTabBar: false,
      returnState: CustomerProfileViewState(tabIndex: 2),
    )
  ];
  var appBloc;
  @override
  Widget build(BuildContext context) {
    appBloc = context.getAppBloc();
    return DefaultTabController(
      initialIndex: widget.tabIndex == null ? 0 : widget.tabIndex,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeScheme.iconColorDrawer,
          title: GeneralText(
            'My Profile',
            fontSize: 20,
          ),
          leading: TabBackButton(
            callback: () {
              appBloc.moveBack();
            },
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            // unselectedLabelColor: Colors.redAccent,
            //unselectedLabelStyle:ThemeScheme.lightTheme.primaryColor ,
            tabs: <Widget>[
              Tab(
                text: 'Profile ',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'Addresses',
                icon: Icon(
                  Icons.work,
                ),
              ),
              Tab(
                text: 'My Orders',
                icon: Icon(Icons.location_on),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: containers,
        ),
      ),
    );
  }
}
