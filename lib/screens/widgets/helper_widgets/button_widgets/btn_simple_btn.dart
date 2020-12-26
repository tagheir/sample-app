import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/text_widgets/general-text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  SimpleButton({this.text,this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        padding: const EdgeInsets.all(8.0),
        textColor: Colors.white,
        color: ThemeScheme.iconColorDrawer,
        onPressed: () {
          this.onPressed();
        },
        child: GeneralText(this.text, color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15,),
      ),
    );
  }
}
