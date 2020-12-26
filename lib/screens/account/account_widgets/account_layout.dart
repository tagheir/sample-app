import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';

class AccountScreenLayoutWidget extends StatefulWidget {
  final void Function() onBackPressed;
  final void Function() onActionPressed;
  final void Function() onFooterPressed;
  final String actionText;
  final String buttonText;
  final Function() onSubmitPressed;
  final String appBarText;
  final String footerText1;
  final String footerText2;
  final String pageDescription;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Widget body;
  final bool autoValidate;
  final bool isSignUpScreen;

  const AccountScreenLayoutWidget(
      {Key key,
      this.onBackPressed,
      this.onActionPressed,
      this.actionText,
      this.appBarText,
      this.scaffoldKey,
      this.body,
      this.onFooterPressed,
      this.footerText1,
      this.footerText2,
      this.pageDescription,
      this.buttonText,
      this.onSubmitPressed,
      this.formKey,
      this.isSignUpScreen,
      this.autoValidate})
      : super(key: key);

  @override
  _AccountScreenLayoutWidgetState createState() =>
      _AccountScreenLayoutWidgetState();
}

class _AccountScreenLayoutWidgetState extends State<AccountScreenLayoutWidget> {
  double panelHeight;
  bool panelOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          getAppBar(),
          //SizedBox(height: 500,),
          getFormBody(),
        ],
      ),
    );
  }

  getAppBar() {
    //context.getAppBloc().firstTimeLogin;
    return AppBar(
      iconTheme: IconThemeData(color: AppTheme.lightTheme.primaryColor),
      // leading: context.getAppBloc().firstTimeLogin == false
      //     ? FlatButton(
      //         child: Icon(
      //           Icons.arrow_back_ios,
      //           color: AppTheme.lightTheme.primaryColor,
      //           size: 20,
      //         ),
      //         onPressed: () {
      //           widget.onBackPressed();
      //         },
      //       )
      //     : Text(''),
      actions: context.getAppBloc().firstTimeLogin == true
          ? <Widget>[
              FlatButton(
                onPressed: () {
                  widget.onActionPressed();
                },
                child: Text(widget.actionText,
                    style: TextConstants.H6
                        .apply(color: AppTheme.lightTheme.primaryColor)),
              )
            ]
          : <Widget>[
              FlatButton(
                onPressed: () {
                  widget.onBackPressed();
                },
                child: Icon(Icons.close,
                    color: AppTheme.lightTheme.primaryColor, size: 20),
              )
            ],
      elevation: 0,
      backgroundColor: Colors.transparent,

      // centerTitle: true,
    );
  }

  getBody(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 30),
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: LayoutConstants.borderRadius8,
          topRight: LayoutConstants.borderRadius8,
        ),
      ),
      // child:
      //  getFormBody(),
    );
  }

  getFormBody() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          getPageDescription(),
          SizedBox(
            height: 10,
          ),
          widget.body,
          SizedBox(
            height: 30,
          ),
          getSigninButton(),
          SizedBox(
            height: 40,
          ),
          getBottomText(context),
          LayoutConstants.sizedBox20H
        ],
      ),
    );
  }

  getBottomText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onFooterPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: widget.footerText1 ?? '',
                  style: TextConstants.H7.apply(color: LightColor.black)),
              TextSpan(
                  text: widget.footerText2 ?? '',
                  style: TextConstants.H7
                      .apply(color: AppTheme.lightTheme.primaryColor)),
            ]),
          ),
        ),
      ),
    );
  }

  Padding getPageDescription() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        widget.pageDescription ?? '',
        style: TextConstants.H5.apply(color: LightColor.black),
      ),
    );
  }

  getSigninButton() {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Text(
            //   widget.buttonText ?? '',
            //   style: TextConstants.H5.apply(color: LightColor.black),
            // ),
            // SizedBox(
            //   width: 5,
            // ),
            MaterialButton(
                minWidth: 20,
                height: 40,
                onPressed: () {
                  widget.onSubmitPressed();
                },
                color: AppTheme.lightTheme.primaryColor,
                textColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward,
                  size: 24,
                ),
                //padding: EdgeInsets.all(16),
                shape: LayoutConstants.shapeBorderRadius8),
          ],
        ),
      ),
    );
  }
}
