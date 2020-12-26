import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData prefixIcon;
  final IconData suffixIcon;

  const CustomTextField(
      {this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.autoFocus,
      this.inputType,
      this.maxLength,
      this.maxLines,
      this.initialValue,
      this.prefixText,
      this.focusNode,
      this.inputFormatters,
      TextInputType keyboardType});

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final Function onChanged;
  final bool autoFocus;
  final TextInputType inputType;
  final int maxLength;
  final int maxLines;
  final String initialValue;
  final String prefixText;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      autofocus: false,
      keyboardType: widget.inputType,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textAlign: TextAlign.left,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      cursorColor: AppTheme.lightTheme.primaryColor,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor),
        ),
        border: const UnderlineInputBorder(),
        prefixText: widget.prefixText,
        // filled: true,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: AppTheme.lightTheme.primaryColor,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Icon(
                widget.suffixIcon,
                color: AppTheme.lightTheme.primaryColor,
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.black87),
        labelStyle: TextStyle(color: Colors.black87),
        labelText: widget.labelText,
        //  helperText: widget.helperText,
      ),
    );
  }
}
