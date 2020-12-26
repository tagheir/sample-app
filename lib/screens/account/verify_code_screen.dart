import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/authResponse_dto.dart';
import 'package:bluebellapp/models/login_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/screens/account/account_widgets/account_layout.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class VerifyCodeScreen extends StatefulWidget {
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  VerifyCodeScreenData screenData;
  AppScreenBloc appScreenBloc;
  AuthenticationResult authResult;
  bool _autovalidate = false;
  String code;

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(value),
    ));
  }

  submitPin() async {
    if (code == null || code.isEmpty || code.length < 6) {
      showInSnackBar('Pin is invalid');
    } else {
      appScreenBloc.onRequestResponseFunction = (data) {
        authResult = data;
        if (authResult.errors.length > 0) {
          showInSnackBar(authResult.errors.first);
        } else if (authResult?.token != null && authResult?.status == true) {
          context
              .addEvent(EmailOrPasswordVerificationScreenEvent(isEmail: false));
        }
      };
      screenData.code = code;
      appScreenBloc.add(AppScreenRequestEvent(function: screenData.verifyCode));
    }
  }

  initialize() {
    screenData = VerifyCodeScreenData(context.getAppBloc());
    appScreenBloc = context.getAppScreenBloc();
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return LayoutScreen(
      isAppScreenBloc: true,
      showNavigationBar: false,
      showFloatingButton: false,
      childView: AccountScreenLayoutWidget(
        pageDescription: GeneralStrings.VERIFY_CODE_DESCRIPTION,
        actionText: GeneralStrings.SKIP,
        isSignUpScreen: false,
        onActionPressed: () {
          scaffoldKey.addEvent(DashboardScreenEvent());
        },
        appBarText: GeneralStrings.VERIFY_CODE,
        onBackPressed: () {
          scaffoldKey.moveBack();
        },
        scaffoldKey: scaffoldKey,
        body: getForm(),
        autoValidate: _autovalidate,
        formKey: formKey,
        onSubmitPressed: submitPin,
      ),
    );
  }

  Column getForm() {
    return Column(
      children: <Widget>[
        LayoutConstants.sizedBox20H,
        Container(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: PinEntryTextField(
                fields: 6,
                showFieldAsBox: true,
                onSubmit: (String pin) {
                  code = pin;
                }, // end onSubmit
              ),
            ), // end PinEntryTextField()
          ), // end Padding()
        ),
        // LayoutConstants.sizedBox30H,
        // ButtonConstants.primaryBlockButton(
        //   onPressed: submitPin,
        //   child: Text(
        //     GeneralStrings.VERIFY,
        //     style: TextConstants.H6,
        //   ),
        //   shape: LayoutConstants.shapeBorderRadius10,
        // ).center(),
      ],
    );
  }
}
