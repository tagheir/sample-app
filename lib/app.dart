import 'dart:collection';
import 'dart:io';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/models/response_model.dart';
import 'package:bluebellapp/repos/app_repo.dart';
import 'package:bluebellapp/resources/constants/general_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/strings/local_storage_keys.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/services/local_storage_service.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';

class App {
  FluroRouter router;
  RouteObserver<PageRoute> routeObserver;
  bool authenticationCheckedOnAppStart = false;
  bool isUserLoggedIn = false;
  bool firstTimeLogin = false;
  bool isFirstTimeLoad = true;
  bool isFirstTimeDataInitialization = true;
  bool showSplashScreen = true;
  bool isSplashRunning = false;
  AppRepo appRepo;
  AppState currentState;

  //static final SqliteHelper _singleton = SqliteHelper._internal();
  static final App _application = App._internal();

  Queue<AppState> stateHistory;

  factory App() {
    ////print("App called");
    return _application;
  }
  App._internal();
  BuildContext currentContext;

  CategoryType categoryType;
  //Application();

  static App get() {
    return _application;
  }

  AppRepo getRepo() {
    if (appRepo == null) appRepo = AppRepo(this);
    return appRepo;
  }

  setIsFirstTimeDataInitialization() async {
    App.get().isFirstTimeDataInitialization = await LocalStorageService.get(
                LocalStorageKeys.FirstTimeDataInitializationStatus) ==
            null
        ? true
        : false;
  }

  void routeTreePrinter() {
    // ////print(" --------------------- ROUTE TREE START ------------------------");
    // router.//printTree();
    // ////print(" ---------------------  ROUTE TREE END  ------------------------");
  }

  pushStateToHistory(AppState state) {
    if (stateHistory == null) stateHistory = Queue<AppState>();
    //print("HERE In PUsh State");
    //print(state);
    stateHistory.addFirst(state);
  }

  Future<dynamic> navigateToState(BuildContext context, List<AppState> states,
      {bool replace = false,
      AppState returnState,
      bool moveBack = false,
      bool rebuild = false,
      bool isLogin = false}) async {
    //print(stateHistory);
    //print(" ======> to State ---- (${states.toString()} ----return state ===> $returnState, " +
    //    "----Replace = ${(replace ? "Yes " : "No")} ----Rebuild = ${(rebuild ? "Yes " : "No")}");

    //print("moveBack => " + moveBack.toString());
    routeTreePrinter();
    bool stateFound = false;
    if (returnState == null &&
        moveBack == true &&
        states != null &&
        states.length > 0) {
      //print(states);
      returnState = states.first;
      if (rebuild != true) states = states.skip(1).toList();
    }
    //print("states");
    //print(states);
    if (returnState != null) {
      //print(stateHistory);

      int index = 0;
      for (var st in stateHistory) {
        if (st == returnState) {
          stateFound = true;
          break;
        }
        index++;
      }
      //print(index);
      if (stateFound) {
        var popAbleStatesCount = index;
        if (rebuild == true) {
          popAbleStatesCount++;
        }
        for (int i = 0; i < popAbleStatesCount; i++) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
            App.get().currentState = stateHistory.removeFirst();
            //print("REMOVER");
          }
          //print(context);
          //print(stateHistory);
        }
      }

      // Navigator.popUntil(context, (route) => state != )
    }
    for (var state in states) {
      App.get().currentState = state;
      print("Return State => " + state.returnState.toString());
      ////print("START NAVIGATION");
      ////print(context);
      //  print("Current State => ${App.get().currentState}");
      if (state is AppStateAuthenticated && stateHistory.length > 1) {
        while (stateHistory.length > 1) {
          stateHistory.removeFirst();
          Navigator.pop(context);
        }
      } else {
        if (isLogin == true) {
          while (stateHistory.length > 1) {
            stateHistory.removeFirst();
            Navigator.pop(context);
          }
          state = CustomerProfileViewState();
        }
        router
            .navigateTo(
              context,
              state.toString(),
              routeSettings: RouteSettings(arguments: state),
              replace: replace,
            )
            .then(
              (responseNavigation) {},
            );
        //print("HERE");
        pushStateToHistory(state);
      }
    }
  }

  moveBack(BuildContext context, {AppState returnState, bool rebuild = false}) {
    ////print(stateHistory);
    var state = stateHistory.first;
    if (state is AppStateAuthenticated && Platform.isIOS) {
      return;
    } else {
      ////print("Print");
      stateHistory.removeFirst();
      router.pop(context);
    }
    state = stateHistory.first;
    if (rebuild && state.rebuild != null) {
      ////print("Re builder Stater");
      state.rebuild().then((value) => null);
    }
    //print(stateHistory);
  }

  Future<void> add(AppEvent event, {BuildContext context}) async {
    var events = List<AppEvent>();
    events.add(event);
    ////print("HERE 2");
    await addEvents(events, context: context);
  }

  Future<void> addEvents(List<AppEvent> events, {BuildContext context}) async {
    if (events == null || events.length <= 0) return;

    ////print("HERE 3");
    context ??= currentContext;
    //////print(authenticationCheckedOnAppStart);
    AppTheme.deductedHeight = 0.0;
    AppTheme.deductedWidth = 0.0;
    if (GeneralConstants.directoryPath == null) {
      GeneralConstants.directoryPath =
          (await getApplicationDocumentsDirectory()).path;
      ////print("Directory Path => " + GeneralConstants.directoryPath);
    }
    //var eventToStates = List<AppEvent>();
    var count = 0;
    bool replace = false;
    AppState returnState;
    bool moveBack = false;
    bool rebuild = false;
    bool isLogin;
    var states = List<AppState>();
    for (var event in events) {
      ////print("HERE 4");
      if (event is LoginButtonPressedEvent ||
          event is SignUpButtonPressedEvent) {
        isLogin = true;
      }
      var eventToState = await toAppState(event);
      if (eventToState == null) continue;

      ////print("HERE 5");
      if (count == 0) {
        replace = eventToState.replace == true ? true : false;
        returnState = eventToState.returnState;
        moveBack = eventToState.moveBack;
        rebuild = eventToState.rebuild;
      }
      states.add(eventToState.state);
      // if (count > 0) {
      //   context = currentContext;
      // }
      count++;
    }
    //print("moveBack => " + moveBack.toString());
    navigateToState(
      context,
      states,
      replace: replace,
      returnState: returnState,
      isLogin: isLogin,
      moveBack: moveBack,
      rebuild: rebuild,
    );
  }

  Future<EventToState> toAppState(AppEvent event) async {
    if (event is AppStarted) {
      return EventToState(event, AppStateAuthenticated(), replace: true);
    }
    if (event is DashboardScreenEvent) {
      AppTheme.setServicesTheme();
      categoryType = CategoryType.Store;
      return EventToState(event, AppStateAuthenticated());
    }
    if (event is StoreHomeScreenEvent) {
      AppTheme.setStoreTheme();
      //print(AppTheme.lightTheme.primaryColor);
      categoryType = CategoryType.Store;
      return EventToState(event, StoreHomeScreenViewState());
    }
    if (event is ServicesHomeScreenEvent) {
      AppTheme.setServicesTheme();
      categoryType = CategoryType.FacilityManagement;
      return EventToState(event, ServicesHomeScreenViewState());
    }
    if (event is LandscapeHomeScreenEvent) {
      categoryType = CategoryType.Landscape;
      AppTheme.setLandscapeTheme();
      return EventToState(event, LandscapeHomeScreenViewState());
    }
    if (event is LandscapeAllServicesScreenEvent) {
      return EventToState(event, LandscapeAllServicesScreenViewState());
    }
    if (event is LandscapeProjectsScreenViewEvent) {
      return EventToState(event, LandscapeProjectsScreenViewState());
    }
    if (event is LandscapeServiceDetailScreenEvent) {
      return EventToState(
          event, LandscapeServiceDetailScreenState(guid: event.guid));
    }
    if (event is LandscapeProjectImagesScreenEvent) {
      return EventToState(
          event, LandscapeProjectImagesScreenState(guid: event.guid));
    }
    if (event is LandscapeAboutScreenEvent) {
      return EventToState(event, LandscapeAboutScreenState());
    }
    if (event is ContactUsFormScreenEvent) {
      return EventToState(event, ContactUsFormState());
    }
    if (event is LoginScreenEvent) {
      LocalStorageService.get(LocalStorageKeys.FirstTimeLoginStatus)
          .then((status) async {
        if (status != null && firstTimeLogin == true) {
          firstTimeLogin = false;
        } else if (status == null) {
          await LocalStorageService.save(
              LocalStorageKeys.FirstTimeLoginStatus, GeneralStrings.SET);
        }
      });
      return EventToState(
          event,
          AppStateLogin(
            returnState: this.currentState ?? AppStateAuthenticated(),
          ));
    }
    if (event is LoginButtonPressedEvent) {
      var response = await getRepo().getUserRepository().authenticate(
            username: event.loginDto.email.trim(),
            password: event.loginDto.password,
          );
      if (ResponseModel.processFailure(response, event.callBack)) {
        if (response.isAuthorizationError ||
            response.isAuthorizationTokenError) {
          return EventToState(
            event,
            AppStateLogin(returnState: event.returnState),
          );
        }
      }
      if (response.data.errors.length > 0) {
        event.callBack(response.data.errors.first);
        //  return EventToState(event,context,AppStateLogin();
      } else if (response.data.token != null) {
        setAuthToken(response.data.token);
        event.callBack(null);
        var toState = event.returnState ?? AppStateAuthenticated();
        print("toState => " + toState.toString());
        return EventToState(
          event,
          toState,
          moveBack: true,
          rebuild: true,
        );
        // event.callBack(null);
        // return EventToState(event,context,VerifyCodeViewState();
      }
    }

    if (event is SignUpButtonPressedEvent) {
      // return EventToState(event,context,AppStateLoading();
      try {
        var response =
            await getRepo().getUserRepository().signUp(user: event.signUpDto);
        ////print("response received======");
        ////print(response.data.token);
        if (ResponseModel.processFailure(response, event.callBack)) {
          if (response.isAuthorizationError ||
              response.isAuthorizationTokenError) {
            return EventToState(event, AppStateSignUp());
          }
        } else if (response.data.errors.length > 0) {
          if (response.data.errors.length > 0) {
            event.callBack(response.data.errors.first);
            //return EventToState(event,context,AppStateSignUp();
          }
        } else if (response.data.token != null) {
          setAuthToken(response.data.token);
          event.callBack(null);
          return EventToState(event, AppStateAuthenticated());
          // event.callBack(null);
          // return EventToState(event,context,VerifyCodeViewState();
        }
      } catch (e) {
        ////print(e.toString());
      }
    }

    // Verify Code After Login Screen
    if (event is VerifyCodeButtonPressed) {
      var response = await getRepo()
          .getUserRepository()
          .generateTwoFactorAuthentication(code: event.code);
      if (ResponseModel.processFailure(response, event.callBack)) {
        if (response.isAuthorizationError ||
            response.isAuthorizationTokenError) {
          return EventToState(event, AppStateLogin());
        }
      } else if (response?.data?.errors != null) {
        if (response.data.errors.length > 0) {
          event.callBack(response.data.errors.first);
          return EventToState(event, VerifyCodeViewState());
        }
      } else if (response.data.token != null) {
        appRepo.token = response.data.token;
        isUserLoggedIn = true;
        await getRepo().getUserRepository().getCustomerInfo();
        event.callBack(null);
        return EventToState(event, AppStateAuthenticated());
      }
    }

    // Login Event Called (legacy)
    if (event is LoggedIn) {
      //return EventToState(event, AppStateLoading());
      getRepo().getUserRepository().getCustomerInfo().then((value) => null);
      return EventToState(event, AppStateAuthenticated());
    }

    if (event is CategoryScreenEvent) {
      return EventToState(
        event,
        CategoryScreenViewState(
            guid: event.guid,
            isSearch: event.isSearch,
            isService: event.isService),
      );
    }
    if (event is CategoryProductsViewEvent) {
      return EventToState(
          event,
          CategoryProductsViewState(
            products: event.products,
            title: event?.category?.name ?? 'Products',
          ));
    }
    if (event is StoreSearchEvent) {
      return EventToState(event, StoreSearchState());
    }
    if (event is CustomerAddressesViewEvent) {
      return EventToState(
          event, CustomerAddressesViewState(addressType: event.addressType));
    }
    if (event is CustomerAllAddressesViewEvent) {
      return EventToState(event, CustomerAddressesViewState());
    }
    if (event is CreateOrEditAddressViewEvent) {
      return EventToState(
          event,
          CreateOrEditAddressViewState(
              address: event.address,
              addressType: event.addressType,
              returnState: event.returnState),
          returnState: event.returnState);
    }
    if (event is ProductDetailViewEvent) {
      return EventToState(
          event,
          ProductDetailViewState(
              seName: event.seName,
              isCartProduct: event.isCardProduct,
              cartItemId: event.cartItemId));
    }
    if (event is CartItemsViewEvent) {
      if (getRepo().getToken() != null) {
        return EventToState(event, CartItemsViewState());
      } else {
        return EventToState(event, AppStateLogin());
      }
    }
    if (event is CartCheckoutViewEvent) {
      return EventToState(event, CartCheckoutViewState());
    }
    if (event is DirectCheckoutViewEvent) {
      return EventToState(
          event,
          DirectCheckoutViewState(
              addToCartDto: event.addToCartDto, product: event.prod));
    }
    if (event is PaymentMethodViewEvent) {
      return EventToState(event, PaymentMethodViewState());
    }
    if (event is LoggedOut) {
      //return EventToState(event, AppStateLoading());
      var pr = CustomProgressDialog();
      await pr.showDialog();
      isUserLoggedIn = false;
      getRepo().userRepository.deleteToken();
      appRepo = null;
      // await userRepository.deleteToken();
      var toState = currentState ?? AppStateAuthenticated();

      await pr.hideDialog();
      return EventToState(
        event,
        toState,
        moveBack: true,
        rebuild: true,
      );
    }
    if (event is OrdersViewEvent) {
      return EventToState(event, OrdersViewState());
    }
    if (event is SignUpEvent) {
      return EventToState(
          event,
          AppStateSignUp(
            returnState: event.returnState,
          ));
    }
    if (event is StateEvent) {
      return EventToState(event, event.state); //AppStateChange(event.state);
    }
    if (event is OrderDetailViewEvent) {
      return EventToState(
        event,
        OrderDetailViewState(
          orderId: event.orderId,
          returnState: event.returnState,
          moveToPayment: event.moveToPayment,
        ),
        returnState: event.returnState,
      );
    }
    if (event is CustomerProfileViewEvent) {
      return EventToState(
          event,
          CustomerProfileViewState(
              tabIndex: event.tabIndex,
              animationController: event.animationController));
    }
    if (event is EditProfileEvent) {
      return EventToState(event, EditProfileState());
    }
    if (event is PaymentMethodScreenViewEvent) {
      return EventToState(
        event,
        PaymentMethodScreenViewState(
            orderId: event.orderId, returnState: event.returnState),
        returnState: event.returnState,
      );
    }
    if (event is CardPaymentScreenViewEvent) {
      return EventToState(
          event,
          CardPaymentScreenViewState(
            orderId: event.orderId,
          ));
    }
    if (event is VerifyCodeScreenEvent) {
      return EventToState(event, VerifyCodeScreenState());
    }
    if (event is EmailOrPasswordVerificationScreenEvent) {
      return EventToState(
          event,
          EmailOrPasswordVerificationScreenState(
              isEmail: event.isEmail,
              isChangePassword: event.isChangePassword));
    }
    if (event is GalleryViewEvent) {
      return EventToState(
          event,
          GalleryViewState(
              title: event.title,
              imagePaths: event.imagePaths,
              currentIndex: event.currentIndex));
    }
    return Future.value(null);
  }

  setAuthToken(String token) async {
    appRepo.token = token;
    isUserLoggedIn = true;
    await getRepo().getUserRepository().persistToken(token: appRepo.token);
  }
}

class EventToState {
  AppState state;
  AppState returnState;
  AppEvent event;
  bool replace;
  bool moveBack;
  bool rebuild;
  EventToState(
    this.event,
    this.state, {
    this.replace,
    this.returnState,
    this.moveBack = false,
    this.rebuild = false,
  });
}
