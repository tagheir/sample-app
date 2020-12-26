import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';

class BackButtonWrapper extends StatelessWidget {
  final Widget widget;
  final AppState returnState;
  final bool isGeneral;
  BackButtonWrapper({this.widget, this.returnState, this.isGeneral = false});
  @override
  Widget build(BuildContext context) {
    ////print("=========WillPopScope called=========");
    return WillPopScope(
      onWillPop: () {
        ////print("on Will pop Back");
        if (this.isGeneral == true) {
          context.getAppBloc().stateHistory.removeFirst();
          Navigator.pop(context);
          //print(context.getAppBloc().stateHistory);
        }
        //context.moveBack();
        return Future.value(false);
      },
      //context.getAppBloc().moveBack(context, returnState: returnState),
      child: widget,
    );
  }
}
