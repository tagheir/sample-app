import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/contact_us_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/fixed_bottom_button.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/email_field.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/text_field.dart';
import 'package:bluebellapp/services/form_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class ContactUsForm extends StatefulWidget {
  @override
  _ContactUsFormState createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  Widget body;
  ContactUsDto contactUsDto = ContactUsDto();
  AppScreenBloc appScreenBloc;
  GetQuoteRequestScreenData screenData;
  Size size;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var focusNodesList = List<FocusNode>();
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    focusNodesList.add(new FocusNode());
    focusNodesList.add(new FocusNode());
    focusNodesList.add(new FocusNode());
    focusNodesList.add(new FocusNode());
    focusNodesList.add(new FocusNode());
    focusNodesList.add(new FocusNode());

    focusNodesList.forEach((node) {
      node.addListener(() {
        if (node.hasFocus) {
          animateTo(node);
        }
      });
    });
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (!visible) {
          removeFieldsFocus();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  animateTo(FocusNode focusNode) {
    var bottomOffset = MediaQuery.of(context).viewInsets.bottom;
    if (bottomOffset == 0) {
      controller.animateTo(controller.offset + size.height * 0.2,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(microseconds: 800));
    }
  }

  removeFieldsFocus({FocusNode focusNode}) {
    focusNodesList.forEach((node) {
      if (!(focusNode != null && node == focusNode)) {
        node.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if (screenData == null) {
      screenData =
          context.getAppScreenBloc().screenData as GetQuoteRequestScreenData;
    }
    appScreenBloc = context.getAppScreenBloc();
    appScreenBloc.onRequestResponseFunction = (data) {
      if (data != null) {
        showMessage(context, data);
      }
    };
    body = ListView(
      shrinkWrap: true,
      controller: controller,
      children: [getContactUsForm()],
    );

    return LayoutScreen(
      isAppScreenBloc: true,
      childView: body,
      scaffoldKey: scaffoldKey,
      showAppbar: true,
      screenTitle: 'Get Quote',
      showNavigationBar: false,
      showFloatingButton: false,
      // bottomBar: FixedBottomButton(
      //   onTap: () {
      //     if (formKey.currentState.validate()) {
      //       screenData.contactUsDto = contactUsDto;
      //       var submitQuote = screenData.submitQuote;
      //       appScreenBloc.add(AppScreenRequestEvent(function: submitQuote));
      //     }
      //   },
      //   text: "Submit",
      //   tabColor: LightColor.landGreen,
      // ),
    );
  }

  getContactUsForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            suffixIcon: Icons.person,
            validator: (value) {
              return validateFirstName(value);
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
              FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true)
            ],
            maxLength: 20,
            labelText: GeneralStrings.FULL_NAME_FIELD_LABEL,
            onChanged: (String value) {
              setState(() {
                contactUsDto.name = value;
              });
            },
          ),
          LayoutConstants.sizedBox20H,
          EmailField(
            isEmail: true,
            suffixIcon: Icons.email,
            focusNode: focusNodesList[1],
            validator: (value) {
              return validateEmail(value);
            },
            onChanged: (String value) {
              setState(() {
                contactUsDto.emailAddress = value;
              });
            },
          ),
          LayoutConstants.sizedBox20H,
          CustomTextField(
            inputType: TextInputType.text,
            focusNode: focusNodesList[2],
            suffixIcon: Icons.phone,
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
                contactUsDto.phoneNumber = value;
              });
            },
          ),
          LayoutConstants.sizedBox10H,
          CustomTextField(
            suffixIcon: Icons.location_city,
            focusNode: focusNodesList[3],
            validator: (value) {
              return validateMessage(value, "Area", 3);
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            maxLength: 20,
            labelText: GeneralStrings.Area_FIELD_LABEL,
            onChanged: (String value) {
              setState(() {
                contactUsDto.area = value;
              });
            },
          ),
          LayoutConstants.sizedBox20H,
          CustomTextField(
            suffixIcon: Icons.location_on,
            focusNode: focusNodesList[4],
            validator: (value) {
              return validateMessage(value, "Address", 10);
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
            maxLength: 50,
            labelText: GeneralStrings.Address_FIELD_LABEL,
            onChanged: (String value) {
              setState(() {
                contactUsDto.address = value;
              });
            },
          ),
          LayoutConstants.sizedBox20H,
          CustomTextField(
            suffixIcon: Icons.message,
            maxLines: 3,
            focusNode: focusNodesList[5],
            validator: (value) {
              return validateMessage(
                value,
                "Message",
                15,
              );
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(150),
            ],
            maxLength: 150,
            labelText: GeneralStrings.Message_FIELD_LABEL,
            onChanged: (String value) {
              ////print("on changed");
              setState(() {
                contactUsDto.message = value;
              });
            },
          ),
          LayoutConstants.sizedBox30H,
          getSubmitButton(),
          LayoutConstants.sizedBox200H,
        ],
      ),
    ).padding(EdgeInsets.only(left: 24, right: 24, top: 48));
  }

  Future showMessage(BuildContext context, data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data == true
              ? "Quote Request Submitted Successfully"
              : "Something went wrong. Try again."),
          actions: [
            FlatButton(
              child: Text("OK",
                  style: TextConstants.H5
                      .apply(color: AppTheme.lightTheme.primaryColor)),
              onPressed: () {
                Navigator.pop(context);
                formKey.currentState.reset();
              },
            )
          ],
        );
      },
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
              screenData.contactUsDto = contactUsDto;
              var submitQuote = screenData.submitQuote;
              appScreenBloc.add(AppScreenRequestEvent(function: submitQuote));
            }
          },
          color: AppTheme.lightTheme.primaryColor,
          textColor: Colors.white,
          child: Text(
            'Submit',
            style: TextConstants.H6.apply(color: LightColor.white),
          ),
          shape: LayoutConstants.shapeBorderRadius8),
    );
  }
}
