import 'dart:io';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bluebellapp/routes/route_handler.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';

class Routes {
  static String root = "/";

  static void configureRoutes(FluroRouter router) {
    var transition =
        Platform.isIOS ? TransitionType.inFromBottom : TransitionType.material;
    var transitionTime = Platform.isIOS ? 200 : 400;
    router.define(
      "/",
      handler: RouteHandlers.appStarted(),
      transitionType: transition,
      transitionDuration: Duration(milliseconds: transitionTime),
    );

    router.notFoundHandler = Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        context.addEvent(AppStarted());
      },
    );

    router.define(
      "/:params",
      handler: RouteHandlers.root(),
      transitionType: transition,
      transitionDuration: Duration(milliseconds: transitionTime),
    );
  }

  // these are routes
}
