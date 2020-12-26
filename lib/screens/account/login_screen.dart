import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/login_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/screens/account/account_widgets/account_layout.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/email_field.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/password_field.dart';
import 'package:bluebellapp/services/form_validations.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginDto login = LoginDto();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Colors.red,
    ));
  }

  bool _autovalidate = false;
  bool _formWasEdited = false;
  bool isEmail = false;
  CustomProgressDialog pr;
  //BuildContext cntxt;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    emailFocus.unfocus();
    passwordFocus.unfocus();
    if (!_formKey.currentState.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      await pr.showDialog();
      context.addEvent(
        LoginButtonPressedEvent(
          loginDto: login,
          returnState: App.get().currentState?.returnState,
          callBack: (data) async {
            await pr.hideDialog();
            if (data != null) {
              showInSnackBar(data.toString());
            }
          },
        ),
      );
    }
  }

  void handleSignUp() {
    context.addEvent(SignUpEvent());
  }

  @override
  Widget build(BuildContext context) {
    pr = CustomProgressDialog(context: context);
    return AccountScreenLayoutWidget(
      pageDescription: GeneralStrings.SIGNIN,
      actionText: GeneralStrings.SKIP,
      isSignUpScreen: false,
      onActionPressed: () {
        context.addEvent(DashboardScreenEvent());
      },
      appBarText: GeneralStrings.LOGIN,
      onBackPressed: () {
        context.getAppBloc().moveBack(context);
      },
      footerText1: GeneralStrings.DoNotHaveAccount,
      footerText2: GeneralStrings.SIGNUP,
      onFooterPressed: () {
        var event = SignUpEvent();
        event.returnState = App.get().currentState?.returnState;
        context.addEvent(event);
      },
      scaffoldKey: _scaffoldKey,
      body: getLoginForm(),
      autoValidate: _autovalidate,
      buttonText: GeneralStrings.SIGNIN,
      formKey: _formKey,
      onSubmitPressed: _handleSubmitted,
    );
  }

  Form getLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          EmailField(
            focusNode: emailFocus,
            isEmail: true,
            onChanged: (value) {
              setState(() {
                login.email = value.toString().trim();
                isEmail = EmailValidator.validate(login.email) ? true : false;
              });
            },
            validator: (value) {
              login.email = value.toString().trim();
              return validateEmail(login.email);
            },
            onFieldSubmitted: (String value) {
              setState(() {
                login.email = value;
              });
            },
          ),
          LayoutConstants.sizedBox10H,
          // isEmail == true
          //     ?
          PasswordField(
            focusNode: passwordFocus,
            onChanged: (value) {
              setState(() {
                login.password = value;
              });
            },
            validator: (value) {
              return validatePassword(value);
            },
            onFieldSubmitted: (String value) {
              setState(() {
                login.password = value;
              });
            },
          ),
          // : Text(''),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                context.addEvent(
                    EmailOrPasswordVerificationScreenEvent(isEmail: true));
              },
              child: Text(
                GeneralStrings.FORGOT_PASSWORD_2,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700),
              ),
            ),
          ),
        ],
      ).padding(EdgeInsets.only(left: 20, right: 20)),
    );
  }

  // Future<bool> _warnUserAboutInvalidData() async {
  //   final FormState form = _formKey.currentState;
  //   if (form == null || !_formWasEdited || form.validate()) return true;

  //   return await showDialog<bool>(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('This form has errors'),
  //             content: const Text('Really leave this form?'),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: const Text(GeneralStrings.YES),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(true);
  //                 },
  //               ),
  //               FlatButton(
  //                 child: const Text(GeneralStrings.NO),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(false);
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       ) ??
  //       false;
  // }
}
