import 'package:bluebellapp/resources/constants/colors.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/common.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField(
      {this.fieldKey,
      this.isEmail,
      this.hintText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.focusNode,
      this.suffixIcon,
      this.circularBorder = false});

  final Key fieldKey;
  final bool isEmail;
  final String hintText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final Function onChanged;
  final FocusNode focusNode;
  final bool circularBorder;
  final IconData suffixIcon;

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      cursorColor: AppTheme.lightTheme.primaryColor,
      decoration: Common.getInputDecoration(
        //  backgroundColor: Colors.grey.shade100,
        color: BBColors.primaryColor,
        circularBorder: widget.circularBorder,
        // helperText: widget.isEmail== true? GeneralStrings.EMAIL_FIELD_HELPER : GeneralStrings.EMAIL_OR_PHONE_FIELD_HELPER,
        hintText: widget.hintText,
        icon: widget.suffixIcon == null ? Icons.email : null,
        suffixIcon: widget.suffixIcon != null ? widget.suffixIcon : null,
        labelText: widget.isEmail == true
            ? GeneralStrings.EMAIL_FIELD_LABEL
            : GeneralStrings.EMAIL_OR_PHONE_FIELD_LABEL,
      ),
    );
  }
}
