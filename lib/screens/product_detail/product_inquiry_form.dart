import 'package:bluebellapp/models/contact_us_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/simple_form_field.dart';
import 'package:bluebellapp/services/form_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ProductInquiryForm extends StatelessWidget {
  Function(ContactUsDto) onInquireFormSubmit;
  ProductInquiryForm({this.onInquireFormSubmit});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Widget> formWidgets = List<Widget>();
  ContactUsDto inquiryFormDto = ContactUsDto();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: LayoutConstants.shapeBorderRadius8,
        child: Container(
          // height: 380,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: LightColor.orange)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(GeneralStrings.SEND_INQUIRY,
                          style:
                              TextConstants.H6.apply(color: LightColor.orange))
                    ],
                  ),
                ),
                getInquiryForm(),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 25, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (formKey.currentState.validate()) {
                            Navigator.pop(context);
                            onInquireFormSubmit(inquiryFormDto);
                            formKey.currentState.reset();
                          }
                        },
                        child: Text(GeneralStrings.SEND,
                            style: TextConstants.H5
                                .apply(color: LightColor.orange)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  getInquiryForm() {
    formWidgets.add(getFormRow(SimpleFormField(
      initialValue: '',
      inputType: TextInputType.text,
      label: 'Name',
      maxLength: 20,
      onChanged: (value) {
        inquiryFormDto.name = value;
      },
      inputFormatters: [LengthLimitingTextInputFormatter(20)],
      validator: (value) {
        return validateFirstName(value);
      },
    )));
    formWidgets.add(getFormRow(SimpleFormField(
      initialValue: '',
      inputType: TextInputType.text,
      label: 'Email',
      //    maxLength: 30,
      onChanged: (value) {
        inquiryFormDto.emailAddress = value;
      },
      validator: (value) {
        return validateEmail(value.toString().trim());
      },
    )));
    formWidgets.add(getFormRow(SimpleFormField(
      inputType: TextInputType.text,
      label: 'Phone Number',
      onChanged: (value) {
        inquiryFormDto.phoneNumber = value;
      },
      prefixText: '+92 ',
      validator: (value) {
        return validatePhoneNumber(value);
      },
    )));
    formWidgets.add(getFormRow(SimpleFormField(
        initialValue: '',
        inputType: TextInputType.text,
        label: 'Message',
        maxLines: 2,
        validator: (value) {
          return validateMessage(value, "Message", 15);
        },
        onChanged: (value) {
          inquiryFormDto.phoneNumber = value;
        })));
    return Form(key: formKey, child: Column(children: formWidgets));
  }

  Padding getFormRow(SimpleFormField formField) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Flexible(child: formField)],
      ),
    );
  }
}
