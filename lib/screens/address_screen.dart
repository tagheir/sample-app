import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/address_enum.dart';
import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:flutter/material.dart';
import 'widgets/views_widgets/addressListTile_widget.dart';

class CustomerAddress extends StatefulWidget {
  final bool showTabBar;
  final AddressType addressType;
  CustomerAddress({this.showTabBar, this.addressType});
  @override
  _AddressesListState createState() => _AddressesListState();
}

class _AddressesListState extends State<CustomerAddress> {
  @override
  void initState() {
    super.initState();
  }

  int selectedRadioTile = 0;
  List<CustomerAddressDto> addresses;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAddressUpdated = false;
  int groupValue = -1;
  bool isDataLoaded = false;
  CustomProgressDialog pd;
  App appBloc;
  AppScreenBloc appScreenBloc;
  AddressesScreenData screenData;

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  updateAddress(CustomerAddressDto address) async {
    screenData.customerAddress = address;
    screenData.addressType =
        widget.addressType == null ? AddressType.None : widget.addressType;
    appScreenBloc
        .add(AppScreenRequestEvent(function: screenData.upDateAddress));
  }

  initialize() {
    if (App.get().currentState.rebuild == null) {
      print("===rebuild null===");
      App.get().currentState.rebuild = () async {
        pd.showDialog();
        var data = (await context.getAppScreenBloc().screenData.getScreenData())
            .data as List<CustomerAddressDto>;
        print("===data received===");
        ////print(data.billingAddress);
        pd.hideDialog();
        setState(() {
          addresses = data;
        });
      };
    }
    appBloc = context.getAppBloc();
    if (addresses == null) {
      addresses = context.getAppScreenBloc().data;
      if (widget.addressType != null) {
        var addressInfo =
            context.getAppBloc().getRepo().getUserRepository()?.profileInfo;
        groupValue = widget.addressType == AddressType.BillingAddress
            ? addressInfo?.billingAddressId
            : addressInfo.shippingAddressId;
      }
    }
    screenData = AddressesScreenData(appBloc);
    appScreenBloc = context.getAppScreenBloc();
    appScreenBloc.onRequestResponseFunction = (data) {
      if (data == true) {
        appBloc.moveBack(context, rebuild: true);
      }
    };
  }

  // int customselectedRadioTile = 0;
  @override
  Widget build(BuildContext context) {
    pd = CustomProgressDialog(context: context);
    initialize();
    return LayoutScreen(
      scaffoldKey: scaffoldKey,
      addBackButton: true,
      showNavigationBar: false,
      isAppScreenBloc: true,
      floatingActionButton: getAddAddressButton(context),
      childView: getAddressTilesWidget(context),
    );
  }

  Widget getAddressTilesWidget(BuildContext context) {
    var list = new List<Widget>();
    list.add(_title(context));
    list.add(getAddressTile(context));
    return ListView(
      children: [Column(children: list)],
    );
  }

  Container _title(BuildContext context) {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Addresses', style: TextConstants.H5),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  FloatingActionButton getAddAddressButton(BuildContext cntxt) {
    return FloatingActionButton(
      backgroundColor: AppTheme.lightTheme.primaryColor,
      onPressed: () {
        appBloc.add(CreateOrEditAddressViewEvent(
            returnState: widget.addressType == AddressType.BillingAddress
                ? CartCheckoutViewState()
                : CustomerProfileViewState(tabIndex: 1),
            addressType: widget.addressType == null
                ? AddressType.None
                : widget.addressType));
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      heroTag: 'Add Address',
    );
  }

  Widget getAddressTile(BuildContext cntxt) {
    if (addresses == null || addresses.length <= 0)
      return DataEmpty(message: GeneralStrings.NO_ADDRESSES);
    return Container(
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullHeight(context) - 150,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: addresses.length,
        itemBuilder: (context, int i) => GestureDetector(
          onTap: () async {
            if (widget.addressType != null) {
              await updateAddress(addresses[i]);
            }
          },
          child: AddressListTile(
            add: addresses[i],
            value: addresses[i].id,
            groupValue: groupValue,
            callBack: () {
              appBloc.add(CreateOrEditAddressViewEvent(
                  address: addresses[i],
                  returnState: widget.addressType == AddressType.BillingAddress
                      ? CartCheckoutViewState()
                      : CustomerProfileViewState(tabIndex: 1),
                  addressType: widget.addressType == null
                      ? AddressType.None
                      : widget.addressType));
            },
          ),
        ),
      ),
    );
  }
}
