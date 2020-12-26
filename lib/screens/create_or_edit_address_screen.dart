import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/address_enum.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/fixed_bottom_button.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'shared/_layout_screen_updated.dart';
import 'widgets/helper_widgets/button_widgets/tab_back_button.dart';
import 'widgets/helper_widgets/simple_form_field.dart';
import 'widgets/helper_widgets/text_widgets/general-text.dart';
import 'package:bluebellapp/services/form_validations.dart';

class CreateOrEditAddressScreen extends StatefulWidget {
  CustomerAddressDto address;
  final AddressType addressType;
  final AppState returnState;
  CreateOrEditAddressScreen({
    this.address,
    this.addressType,
    this.returnState,
  });
  @override
  _CreateOrEditAddressScreenState createState() =>
      _CreateOrEditAddressScreenState();
}

class _CreateOrEditAddressScreenState extends State<CreateOrEditAddressScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //await pd.hideDialog();
    super.dispose();
  }

  App appBloc;
  AppScreenBloc appScreenBloc;
  EditAddressScreenData screenData;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FormState formState = FormState();
  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  updateAddress() {
    screenData.customerAddress = widget.address;
    screenData.addressType =
        widget.addressType == null ? AddressType.None : widget.addressType;

    appScreenBloc
        .add(AppScreenRequestEvent(function: screenData.createOrEditAddress));
  }

  @override
  Widget build(BuildContext context) {
    appBloc = context.getAppBloc();
    appScreenBloc = context.getAppScreenBloc();
    screenData = EditAddressScreenData(appBloc);
    if (widget.address == null) {
      widget.address = CustomerAddressDto();
    }
    appScreenBloc.onRequestResponseFunction = (data) {
      if (data == true) {
        appBloc.moveBack(context, rebuild: true);
      }
    };

    return LayoutScreen(
      scaffoldKey: scaffoldKey,
      isAppScreenBloc: true,
      addBackButton: true,
      showNavigationBar: false,
      childView: getForm(),
      showFloatingButton: false,
    );
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeScheme.iconColorDrawer,
      title: GeneralText(
        'Address',
        fontSize: 20,
      ),
      leading: TabBackButton(
        callback: () {
          appBloc.moveBack(context);
        },
      ),
    );
  }

  Container _title(BuildContext context) {
    return Container(
      //  margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Address', style: TextConstants.H6_5),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  getForm() {
    print(widget?.address?.phoneNumber);
    return ListView(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _title(context),
              SimpleFormField(
                initialValue: widget.address?.firstName,
                inputType: TextInputType.text,
                label: 'Firstname *',
                maxLength: 20,
                onChanged: (value) {
                  widget.address.firstName = value;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true)
                ],
                validator: (value) {
                  return validateFirstName(value);
                },
              ),
              SimpleFormField(
                  initialValue: widget.address?.lastName,
                  inputType: TextInputType.text,
                  label: 'Lastname *',
                  maxLength: 20,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                    FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true)
                  ],
                  validator: (value) {
                    return validateLastName(value);
                  },
                  onChanged: (value) {
                    widget.address.lastName = value;
                  }),
              SimpleFormField(
                  initialValue: widget?.address?.phoneNumber == null
                      ? ''
                      : widget?.address?.phoneNumber,
                  inputType: TextInputType.number,
                  label: 'Phone number *',
                  prefixText: '+92 ',
                  maxLength: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    return validatePhoneNumber(value);
                  },
                  onChanged: (value) {
                    widget.address.phoneNumber = value;
                  }),

              SimpleFormField(
                  initialValue: widget.address?.address1,
                  inputType: TextInputType.text,
                  label: 'Address *',
                  maxLength: 50,
                  validator: (value) {
                    return validateMessage(
                      value,
                      "Address",
                      3,
                    );
                  },
                  onChanged: (value) {
                    widget.address.address1 = value;
                  }),
              SimpleFormField(
                  initialValue: widget.address?.city,
                  inputType: TextInputType.text,
                  label: 'City *',
                  maxLength: 20,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                    FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true)
                  ],
                  validator: (value) {
                    return validateMessage(
                      value,
                      "City",
                      3,
                    );
                    ;
                  },
                  onChanged: (value) {
                    widget.address.city = value;
                  }),
              LayoutConstants.sizedBox30H,
              getSubmitButton(),
              LayoutConstants.sizedBox100H,
              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //     child: getFormField(
              //         initialValue: widget.address?.stateProvinceName,
              //         inputType: TextInputType.text,
              //         label: 'State/province *',
              //         maxLength: 15,
              //         onChanged: (value) {
              //           widget.address.stateProvinceName = value;
              //         })),

              //getSaveButton(),
            ],
          ).padding(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ],
    );
  }

  getSubmitButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: MaterialButton(
          minWidth: 20,
          height: 40,
          onPressed: () {
            if (formKey.currentState.validate()) {
              updateAddress();
            }
          },
          color: AppTheme.lightTheme.primaryColor,
          textColor: Colors.white,
          child: Text(
            'Save',
            style: TextConstants.H6.apply(color: LightColor.white),
          ),
          shape: LayoutConstants.shapeBorderRadius8),
    );
  }
}
