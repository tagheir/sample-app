import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/button_widgets/tab_back_button.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/text_widgets/general-text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardPayment extends StatelessWidget {
  var maskFormatter =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeScheme.lightTheme.primaryColor,
      appBar: getAppBar(context),
      body: getCardDetail(context),
    );
  }

  Container getCardDetail(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    // color: Colors.green,
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      getFormField(inputType: TextInputType.number,maxLength: 15,label: 'Name on Card'),
                      
                      SizedBox(
                        height: 15,
                      ),
                      getFormField(inputType: TextInputType.phone,maxLength: 16,label: 'Card Number'),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: 
                              TextFormField(
                                inputFormatters: [maskFormatter],
                                keyboardType: TextInputType.datetime,
                                decoration:
                                    InputDecoration(labelText: 'MM/YY'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: getFormField(inputType: TextInputType.phone,maxLength: 3,label: 'CVC'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    child: Text('Apply'),
                    color: ThemeScheme.lightTheme.primaryColor,
                  ),
                )
              ],
            )))
          ],
        ),
      ),
    );
  }

  TextFormField getFormField({TextInputType inputType,int maxLength, String label, List<TextInputFormatter> formatter}) {
    return TextFormField(
      keyboardType: inputType,
      autofocus: false,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(labelText: label),
    );
  }
  AppBar getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeScheme.iconColorDrawer,
      title: GeneralText(
        'Save Card Info',
        fontSize: 20,
      ),
      leading: TabBackButton(
        callback: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
