import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/signup_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/screens/account/account_widgets/account_layout.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/email_field.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/password_field.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/text_field.dart';
import 'package:bluebellapp/services/form_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SignUpDto signUp = SignUpDto();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Colors.red,
    ));
  }

  bool _autovalidate = false;
  bool _formWasEdited = false;
  CustomProgressDialog pr;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _nameFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _phoneFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();
  //final _UsNumberTextInputFormatter _phoneNumberFormatter = _UsNumberTextInputFormatter();
  Future<void> _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      await pr.showDialog();
      context.addEvent(SignUpButtonPressedEvent(
          signUpDto: signUp,
          returnState: App.get().currentState?.returnState,
          callBack: (data) async {
            ////print("=============data received==========");
            await pr.hideDialog();
            if (data != null) {
              showInSnackBar(data.toString());
            }
          }));

      //showInSnackBar('${signUp.email}\'s');
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = CustomProgressDialog(context: context);
    return AccountScreenLayoutWidget(
      body: getSignUpForm(),
      pageDescription: GeneralStrings.Create_Account,
      isSignUpScreen: true,
      actionText: GeneralStrings.SKIP,
      onActionPressed: () {
        context.addEvent(DashboardScreenEvent());
      },
      appBarText: GeneralStrings.SIGNUP,
      onBackPressed: () {
        context.getAppBloc().moveBack(context);
      },
      footerText1: GeneralStrings.AlreadyHaveAccount,
      footerText2: GeneralStrings.LOGIN_2,
      onFooterPressed: () {
        context.addEvent(LoginScreenEvent());
      },
      scaffoldKey: _scaffoldKey,
      autoValidate: _autovalidate,
      formKey: _formKey,
      onSubmitPressed: _handleSubmitted,
    );
  }

  Form getSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            fieldKey: _nameFieldKey,
            // helperText: GeneralStrings.FIRST_NAME_FIELD_HELPER,
            prefixIcon: Icons.person,
            validator: (value) {
              return validateFirstName(value);
            },
            maxLength: 20,
            labelText: GeneralStrings.FIRST_NAME_FIELD_LABEL,
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
              FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true)
            ],
            onChanged: (String value) {
              setState(() {
                signUp.firstName = value;
              });
            },
          ),
          LayoutConstants.sizedBox10H,
          CustomTextField(
            //fieldKey: _nameFieldKey,
            // helperText: GeneralStrings.LAST_NAME_FIELD_HELPER,
            prefixIcon: Icons.person,
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
              FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true)
            ],
            validator: (value) {
              return validateLastName(value);
            },
            maxLength: 20,
            labelText: GeneralStrings.LAST_NAME_FIELD_LABEL,
            onChanged: (String value) {
              setState(() {
                signUp.lastName = value;
              });
            },
          ),
          LayoutConstants.sizedBox10H,
          EmailField(
            fieldKey: _emailFieldKey,
            isEmail: true,
            validator: (value) {
              return validateEmail(value);
            },
            onChanged: (String value) {
              setState(() {
                signUp.email = value;
              });
            },
          ),
          LayoutConstants.sizedBox10H,
          CustomTextField(
            inputType: TextInputType.text,
            fieldKey: _phoneFieldKey,
            prefixIcon: Icons.phone,
            //prefixText: '+92 ',
            validator: (value) {
              return validatePhoneNumber(value);
            },
            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(20),
            //   FilteringTextInputFormatter(
            //     RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$'),
            //     allow: true,
            //   )
            // ],
            // inputFormatters: [
            //   FilteringTextInputFormatter.digitsOnly,
            //   LengthLimitingTextInputFormatter(10),
            // ],
            maxLength: 15,
            //  helperText: GeneralStrings.PHONE_NUMBER_FIELD_HELPER,
            labelText: GeneralStrings.PHONE_NUMBER_FIELD_LABEL,
            onChanged: (String value) {
              setState(() {
                signUp.phoneNumber = value;
              });
            },
          ),
          LayoutConstants.sizedBox10H,
          PasswordField(
            fieldKey: _passwordFieldKey,
            validator: (value) {
              return validatePassword(value);
            },
            onChanged: (String value) {
              setState(() {
                signUp.password = value;
              });
            },
          ),
        ],
      ).padding(EdgeInsets.only(left: 20, right: 20)),
    );
  }
}
