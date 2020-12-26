import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/authResponse_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/shared/status_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custome_alert_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/email_field.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/password_field.dart';
import 'package:bluebellapp/services/form_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'account_widgets/account_layout.dart';

class EmailOrPasswordVerificationScreen extends StatefulWidget {
  final bool isEmail;
  final bool isChangePassword;
  EmailOrPasswordVerificationScreen({this.isEmail, this.isChangePassword});
  @override
  _EmailOrPasswordVerificationScreenState createState() =>
      _EmailOrPasswordVerificationScreenState();
}

class _EmailOrPasswordVerificationScreenState
    extends State<EmailOrPasswordVerificationScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthenticationResult authenticationResult;
  EmailOrPasswordVerificationScreenData screenData;
  AppScreenBloc appScreenBloc;
  String emailOrPassword;
  String oldPassword;
  String newPassword;
  String pageDesc;

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        value,
        style: TextConstants.H8.apply(color: LightColor.white),
      ),
    ));
  }

  handleSubmitted() {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(new FocusNode());
      appScreenBloc.onRequestResponseFunction = (data) {
        authenticationResult = data;
        if (authenticationResult.token != null) {
          if (widget.isEmail == true) {
            context.addEvent(VerifyCodeScreenEvent());
          } else if (widget.isEmail == false) {
            context.addEvent(DashboardScreenEvent());
          }
        } else if (authenticationResult.errors.length > 0) {
          showInSnackBar(authenticationResult.errors.first);
        } else if (authenticationResult.tokenStatus == false &&
            authenticationResult.status == false) {
          if (widget.isEmail == true) {
            showInSnackBar(
                GeneralStrings.USER_DOES_NOT_EXISTS_EMAIL_PHONE_NUMBER);
          }
        } else if (authenticationResult.status == true) {
          formKey.currentState.reset();
          CustomAlertDialog.showNew(
              cntxt: context, text: GeneralStrings.PASSWORD_UPDATED);
          Future.delayed(Duration(seconds: 4), () {
            context.moveBack();
          });
          // StatusDialog(
          //         cntxt: context,
          //         message: GeneralStrings.PASSWORD_UPDATED,
          //         status: true)
          //     .show();
        } else if (authenticationResult.status == false) {
          StatusDialog(cntxt: context, status: false).show();
        }
      };
      if (widget.isEmail == true) {
        screenData.emailOrPassword = emailOrPassword;
        appScreenBloc
            .add(AppScreenRequestEvent(function: screenData.verifyEmail));
      }
      if (widget.isEmail == false) {
        screenData.emailOrPassword = emailOrPassword;
        appScreenBloc
            .add(AppScreenRequestEvent(function: screenData.resetPassword));
      } else if (widget.isChangePassword == true) {
        if (emailOrPassword == newPassword) {
          showInSnackBar("New password same as old password...");
        } else {
          screenData.oldPassword = emailOrPassword;
          screenData.newPassword = newPassword;
          appScreenBloc
              .add(AppScreenRequestEvent(function: screenData.changePassword));
        }
      }
    }
  }

  initialize() {
    appScreenBloc = context.getAppScreenBloc();
    screenData = EmailOrPasswordVerificationScreenData(context.getAppBloc());
    if (widget.isEmail == true) {
      pageDesc = GeneralStrings.ENTER_EMAILADDRESS_OR_PHONENUMBER;
    } else if (widget.isEmail == false) {
      pageDesc = GeneralStrings.ENTER_NEW_PASSWORD;
    } else if (widget.isChangePassword == true) {
      pageDesc = GeneralStrings.CHANGE_PASSWORD;
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return LayoutScreen(
      isAppScreenBloc: true,
      showNavigationBar: false,
      showFloatingButton: false,
      childView: AccountScreenLayoutWidget(
        pageDescription: pageDesc,
        actionText: GeneralStrings.SKIP,
        isSignUpScreen: false,
        onActionPressed: () {
          context.addEvent(DashboardScreenEvent());
        },
        // appBarText: GeneralStrings.LOGIN,
        onBackPressed: () {
          context.moveBack();
        },

        scaffoldKey: scaffoldKey,
        body: getEmailOrPasswordVerifyForm(),
        formKey: formKey,
        onSubmitPressed: handleSubmitted,
      ),
    );
  }

  getEmailOrPasswordVerifyForm() {
    List<Widget> passwordOrEmailFieldWidget = List<Widget>();
    if (widget.isEmail == true) {
      passwordOrEmailFieldWidget.add(EmailField(
        onChanged: (value) {
          setState(() {
            emailOrPassword = value.toString().trim();
          });
        },
        isEmail: true,
        validator: (value) {
          emailOrPassword = value.toString().trim();
          return validateEmail(emailOrPassword);
        },
        onFieldSubmitted: (String value) {
          setState(() {
            emailOrPassword = value;
          });
        },
      ));
    }
    if (widget.isEmail == false || widget.isChangePassword == true) {
      passwordOrEmailFieldWidget.add(PasswordField(
        onChanged: (value) {
          setState(() {
            emailOrPassword = value;
          });
        },
        validator: (value) {
          return validatePassword(value);
        },
        labelText: widget.isChangePassword == true
            ? GeneralStrings.OLD_PASSWORD
            : null,
        onFieldSubmitted: (String value) {
          setState(() {
            emailOrPassword = value;
          });
        },
      ));
    }
    if (widget.isChangePassword == true) {
      passwordOrEmailFieldWidget.add(LayoutConstants.sizedBox20H);
      passwordOrEmailFieldWidget.add(PasswordField(
        onChanged: (value) {
          setState(() {
            newPassword = value;
          });
        },
        validator: (value) {
          return validatePassword(value);
        },
        labelText: GeneralStrings.NEW_PASSWORD,
        onFieldSubmitted: (String value) {
          setState(() {
            newPassword = value;
          });
        },
      ));
    }
    return Form(
      key: formKey,
      child: Column(
        children: passwordOrEmailFieldWidget,
      ).padding(EdgeInsets.only(left: 20, right: 20)),
    );
  }
}
