import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/resources/constants/general_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/strings/local_storage_keys.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'app_screen_event.dart';
import 'app_screen_state.dart';
import 'package:bloc/bloc.dart';

class AppScreenBloc<T> extends Bloc<AppScreenEvent, AppScreenState> {
  @override
  AppScreenState get initialState => AppScreenUninitializedState();

  AppState returnState;
  ScreenData screenData;
  Widget screen;

  AppScreenBloc(AppScreenState initialState,
      {this.screenData, this.screen, this.returnState})
      : super(initialState);

  dynamic data;
  dynamic responseData;
  bool onScreenLoading = false;
  Null Function(bool) onScreenLoadingFunction;
  Null Function(dynamic data) onRequestResponseFunction;

  @override
  Stream<AppScreenState> mapEventToState(AppScreenEvent event) async* {
    var app = App.get();
    //print("Event Exec ============> " + event.toString());

    if (GeneralConstants.directoryPath == null) {
      GeneralConstants.directoryPath =
          (await getApplicationDocumentsDirectory()).path;
      ////print("Directory Path => " + GeneralConstants.directoryPath);
    }
    //var splashRunning = false;
    if (app.authenticationCheckedOnAppStart == false) {
      //splashRunning = true;
      if (!app.isSplashRunning) {
        yield AppStateMainSplash();
      }
      app.isUserLoggedIn = false;
      app.getRepo().getUserRepository().hasToken().then((hasToken) async {
        ////print("h1");
        if (hasToken == true) {
          ////print("h2");
          var verifyToken =
              await app.getRepo().getUserRepository().verifyToken();
          if (verifyToken == true) {
            await app.getRepo().getUserRepository().getCustomerInfo();
            app.isUserLoggedIn = true;
          }
        } else {
          AppTheme.setServicesTheme();
        }
        app.authenticationCheckedOnAppStart = true;
      });
    }

    var checkAndShowOnBoarding = false;
    if (checkAndShowOnBoarding) {
      var status =
          await LocalStorageService.get(LocalStorageKeys.OnBoardingStatus);
      if (status == null) {
        yield AppStateOnboarding();
        //navigateToState(context, AppStateOnboarding(), replace: true);
        await LocalStorageService.save(
            LocalStorageKeys.OnBoardingStatus, GeneralStrings.SET);
        return;
      } else {
        status = await LocalStorageService.get(
            LocalStorageKeys.FirstTimeLoginStatus);
        if (status == null) {
          app.add(LoginScreenEvent());
          app.firstTimeLogin = false;
          await LocalStorageService.save(
              LocalStorageKeys.FirstTimeLoginStatus, GeneralStrings.SET);
        } else {
          app.firstTimeLogin = false;
        }
        return;
      }
    }
    var currentState = app.currentState;
    //print(currentState.toString());
    if (currentState != null && currentState.requireAuthorization == true) {
      if (app.isUserLoggedIn == false) {
        //print("User Not Authorized For State");
      } else {
        //print("User is Authorized For State");
      }
    }

    if (event is AppScreenLoadingEvent) {
      //print("======App screen loading event======");
      if (!app.isSplashRunning) {
        yield AppScreenLoadingState();
      }
      if (screenData != null && screen != null) {
        var response = await screenData.getScreenData();
        if (response != null && response.success) {
          data = response.data;
          yield AppScreenSuccessState(screen: screen, returnState: returnState);
        } else {
          if (response.isAuthorizationError == true ||
              response.isAuthorizationTokenError == true) {
            App.get().add(LoginScreenEvent());
            await Future.delayed(Duration(seconds: 2));
          }
          yield AppScreenFailureState(str: response?.failureError);
        }
      } else if (screenData == null && screen != null) {
        yield AppScreenSuccessState(screen: screen, returnState: returnState);
      }
    }
    if (event is AppScreenRequestEvent) {
      if (onScreenLoadingFunction != null) onScreenLoadingFunction(true);
      yield AppScreenSuccessState(screen: screen);
      var response = await event.function();
      if (onScreenLoadingFunction != null) onScreenLoadingFunction(false);
      if (response != null && response.success) {
        responseData = response.data;
        yield AppScreenSuccessState(screen: screen, returnState: returnState);
        onRequestResponseFunction(responseData);
      } else if (response != null) {
        yield AppScreenFailureState(
          str: response?.failureError ?? 'Server Error',
        );
      }
    }
  }
}
