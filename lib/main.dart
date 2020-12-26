import 'dart:async';
import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/screens/general/task_progress_screen.dart';
import 'package:bluebellapp/services/database_service.dart';
import 'package:path/path.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/routes/router.dart';
import 'package:bluebellapp/services/call_service.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sqflite/sqflite.dart';

GetIt locator = GetIt.asNewInstance();
Future<void> _set() async {
  locator.registerSingleton(CallService);
  var path = await getDatabasesPath();
  var database = openDatabase(
    join(path, DatabaseService.DATABASE_NAME),
    onCreate: DatabaseService.createDatabase,
    onUpgrade: DatabaseService.upgradeDatabase,
    version: DatabaseService.VERSION,
  );
  DatabaseService.database = database;
  await App.get().setIsFirstTimeDataInitialization();
}

Future<void> main() async {
  ////print("============APP STARTED=============");
  WidgetsFlutterBinding.ensureInitialized();
  await _set();
  runApp(AppComponent());
}

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    var routeObserver = RouteObserver<PageRoute>();
    App.get().router = router;
    App.get().routeObserver = routeObserver;
  }

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<NavigatorState> navigatorKey;
  @override
  Widget build(BuildContext context) {
    AppTheme.setServicesTheme();
    AppTheme.setStatusBar();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    navigatorKey ??= GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [App.get().routeObserver],
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
      ),
      title: 'bluebell',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getThemeData(context),
      onGenerateRoute: App.get().router.generator,
    );
    // );
    // home: TaskProgressScreen(
    //   tasks: [
    //     App.get().getRepo().getServiceRepository().getServicesHomeData,
    //     App.get().getRepo().getServiceRepository().getStoreHomeData,
    //     App.get()
    //         .getRepo()
    //         .getServiceRepository()
    //         .getLandscapeHomeViewResponseModel,
    //     App.get()
    //         .getRepo()
    //         .getServiceRepository()
    //         .getDashboardDataResponseModel,
    //   ],
    // ));
  }
}
