import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {this.fieldKey,
      this.hintText,
      this.labelText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.focusNode});

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final Function onChanged;
  final FocusNode focusNode;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      cursorColor: AppTheme.lightTheme.primaryColor,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor),
        ),
        //  filled: true,
        prefixIcon: Icon(
          Icons.lock,
          color: AppTheme.lightTheme.primaryColor,
        ),
        hintText: widget.hintText,
        labelText: widget.labelText == null
            ? GeneralStrings.PASSWORD_FIELD_LABEL
            : widget.labelText,
        hintStyle: TextStyle(color: Colors.black87),
        labelStyle: TextStyle(color: Colors.black87),
        // helperText: GeneralStrings.PASSWORD_FIELD_HELPER,
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            semanticLabel: _obscureText ? 'show password' : 'hide password',
            color: AppTheme.lightTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
