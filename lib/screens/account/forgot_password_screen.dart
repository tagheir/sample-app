import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/login_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/screens/account/account_widgets/account_layout.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/email_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginDto login = LoginDto();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  bool _autovalidate = false;
  bool _formWasEdited = false;
  CustomProgressDialog pr;
  BuildContext cntxt;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final _UsNumberTextInputFormatter _phoneNumberFormatter = _UsNumberTextInputFormatter();
  Future<void> _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      await pr.showDialog();
      // ////print(login.email + login.password);
      context.addEvent(LoginButtonPressedEvent(
          loginDto: login,
          callBack: (data) async {
            ////print("CALL BACK CALLED");
            await pr.hideDialog();
            if (data != null) {
              showInSnackBar(data.toString());
            }

            // ////print("=====================data=============================");
          }));
      // setState(() {
      //   emailFocus.unfocus();
      //   passwordFocus.unfocus();
      // });
      // showInSnackBar('${login.email}\'s');
    }
  }

  String validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      if (value.length < 5) {
        return "Email invalid";
      }
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  void handleSignUp() {
    context.addEvent(SignUpEvent());
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('This form has errors'),
              content: const Text('Really leave this form?'),
              actions: <Widget>[
                FlatButton(
                  child: const Text(GeneralStrings.YES),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: const Text(GeneralStrings.NO),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    pr = CustomProgressDialog(context: context);
    cntxt = context;
    return AccountScreenLayoutWidget(
      pageDescription: GeneralStrings.FORGOT_PASSWORD_DESCRIPTION,
      actionText: GeneralStrings.SKIP,
      onActionPressed: () {
        context.addEvent(DashboardScreenEvent());
      },
      appBarText: GeneralStrings.FORGOT_PASSWORD,
      onBackPressed: () {
        context.getAppBloc().moveBack(context);
      },
      scaffoldKey: _scaffoldKey,
      body: getForm(),
      autoValidate: _autovalidate,
      formKey: _formKey,
    );
  }

  Column getForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 10.0),
        EmailField(
          focusNode: emailFocus,
          onChanged: (value) {
            setState(() {
              login.email = value;
            });
          },
          validator: (value) {
            return validateEmail(value);
          },
          onFieldSubmitted: (String value) {
            setState(() {
              login.email = value;
            });
          },
        ),
        LayoutConstants.sizedBox10H,
        Center(
          child: Padding(
            padding: LayoutConstants.edgeInsets6H12V,
            child: MaterialButton(
              onPressed: _handleSubmitted, //since this is only a UI app
              child: Text(
                GeneralStrings.SUBMIT,
                style: TextConstants.H6,
              ),
              color: Colors.orange,
              elevation: 0,
              minWidth: 400,
              textColor: Colors.white,
              shape: LayoutConstants.shapeBorderRadius10,
            ),
          ),
        ),
      ],
    );
  }
}
