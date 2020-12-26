import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/login_dto.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/email_field.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/password_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LogInOldScreen extends StatefulWidget {
  @override
  _LogInOldScreenState createState() => _LogInOldScreenState();
}

class _LogInOldScreenState extends State<LogInOldScreen> {
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
  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      pr.showDialog();
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

  String validatePassword(String value) {
    if (value == null || value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
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
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: const Text('NO'),
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              context.addEvent(DashboardScreenEvent());
            },
            child: Text(
              GeneralStrings.SKIP,
              style: TextStyle(
                  fontFamily: GeneralStrings.FONT_OPEN_SANS,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.white),
            ),
          ),
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              context.getAppBloc().moveBack(context);
            }),
        backgroundColor: ThemeScheme.lightTheme.primaryColor,
        title: Text(
          "Log In",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          onWillPop: _warnUserAboutInvalidData,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      // Padding(
                      //   padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                      //   child: new Text("LOG IN",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 15.0,
                      //       ),
                      //       textAlign: TextAlign.left),
                      // )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo.png",
                        height: 150.0,
                        width: 210.0,
                        fit: BoxFit.scaleDown,
                      )
                    ],
                  ),
                  Padding(
                    child: getLoginForm(),
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column getLoginForm() {
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
        const SizedBox(height: 24.0),
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
        const SizedBox(height: 24.0),
        Center(
          child: MaterialButton(
            onPressed: _handleSubmitted, //since this is only a UI app
            child: Text(
              'Log In',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: ThemeScheme.swatchColor,
            elevation: 0,
            minWidth: 400,
            height: 50,
            textColor: Colors.white,
            shape: LayoutConstants.shapeBorderRadius8,
          ),
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              'Forgot your password?',
              style: TextStyle(
                  fontFamily: 'SFUIDisplay',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Center(
            child: GestureDetector(
              onTap: () {
                // ////print("The word touched is ");
                context.addEvent(SignUpEvent());
                //_handleSignUp();
              },
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        fontFamily: 'SFUIDisplay',
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  TextSpan(
                      text: " Sign up",
                      style: TextStyle(
                        fontFamily: 'SFUIDisplay',
                        color: Colors.orange,
                        fontSize: 15,
                      ))
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
