import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SimpleFormField extends StatelessWidget {
  int maxLines = 1;
  TextInputType inputType;
  String label;
  String prefixText;
  int maxLength;
  String initialValue;
  Function onChanged;
  Function validator;
  List<TextInputFormatter> inputFormatters;
  TextStyle labelTextStyle;
  SimpleFormField(
      {this.maxLength,
      this.inputType,
      this.label,
      this.maxLines,
      this.initialValue,
      this.validator,
      this.prefixText,
      this.inputFormatters,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      initialValue: initialValue,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black54),
          prefixText: prefixText
          //   errorText:  'This field is required' ,
          ),
    );
  }
}
