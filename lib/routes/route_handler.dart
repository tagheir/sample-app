import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_state.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/category_compact_dto.dart';
import 'package:bluebellapp/models/create_order_response.dart';
import 'package:bluebellapp/models/dashboard_view_model.dart';
import 'package:bluebellapp/models/homeViewModel.dart';
import 'package:bluebellapp/models/landscapeHomeViewModel.dart';
import 'package:bluebellapp/services/local_storage_service.dart';
import 'package:bluebellapp/models/landscape_project_dto.dart';
import 'package:bluebellapp/models/landscape_service_detail_dto.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/strings/local_storage_keys.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/storeHomeViewModel.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/about_bluebell/contactUs_form.dart';
import 'package:bluebellapp/screens/account/email_password_verification_screen.dart';
import 'package:bluebellapp/screens/account/login_screen.dart';
import 'package:bluebellapp/screens/account/signup_screen.dart';
import 'package:bluebellapp/screens/account/verify_code_screen.dart';
import 'package:bluebellapp/screens/address_screen.dart';
import 'package:bluebellapp/screens/cart/cart_items_screen.dart';
import 'package:bluebellapp/screens/category/category_screen.dart';
import 'package:bluebellapp/screens/create_or_edit_address_screen.dart';
import 'package:bluebellapp/screens/general/main_splash_screen.dart';
import 'package:bluebellapp/screens/general/splash_screen.dart';
import 'package:bluebellapp/screens/general/task_progress_screen.dart';
import 'package:bluebellapp/screens/home/dashboard_home.dart';
import 'package:bluebellapp/screens/home/landscape_home_screen.dart';
import 'package:bluebellapp/screens/home/service_home_screen.dart';
import 'package:bluebellapp/screens/home/store_home_screen.dart';
import 'package:bluebellapp/screens/landscape/gallery_view.dart';
import 'package:bluebellapp/screens/landscape/landscape_about_screen.dart';
import 'package:bluebellapp/screens/landscape/landscape_all_services_screen.dart';
import 'package:bluebellapp/screens/landscape/landscape_project_images_screen.dart';
import 'package:bluebellapp/screens/landscape/landscape_projects_screen.dart';
import 'package:bluebellapp/screens/landscape/landscape_service_detail_screen.dart';
import 'package:bluebellapp/screens/loading_screen.dart';
import 'package:bluebellapp/screens/my/edit_profile_screen.dart';
import 'package:bluebellapp/screens/my/profile_screen.dart';
import 'package:bluebellapp/screens/onboarding/onboarding_screen.dart';
import 'package:bluebellapp/screens/orders/card_payment_screen.dart';
import 'package:bluebellapp/screens/orders/cart_checkout_screen.dart';
import 'package:bluebellapp/screens/orders/direct_checkout_screen.dart';
import 'package:bluebellapp/screens/orders/order_detail_screen.dart';
import 'package:bluebellapp/screens/orders/orders_screen.dart';
import 'package:bluebellapp/screens/orders/paymentmethod_screen.dart';
import 'package:bluebellapp/screens/product_detail/product_detail_screen.dart';
import 'package:bluebellapp/screens/shared/error_screen.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/device_back_button.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteHandlers {
  static App app() => App.get();

  static Handler appStarted() => Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          //print("App Started");
          var state = AppStateAuthenticated();
          App.get().pushStateToHistory(state);
          return builder(context, state);
        },
      );

  static Handler root() => Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var state = context.settings.arguments as AppState;
          //AppState state = params["state"];
          if (state == null) {
            state = AppStateAuthenticated();
          }
          ////print(state);
          return builder(context, state);
        },
      );

  static getAppScreenBlocBuilder<T>(
      {ScreenData screenData, Widget screen, AppState returnState}) {
    return BlocProvider<AppScreenBloc>(
      key: UniqueKey(),
      create: (context) => AppScreenBloc<T>(
        AppScreenUninitializedState(),
        screenData: screenData,
        screen: screen,
        returnState: returnState,
      ),
      child: ScreenWidget<T>(
        screen: screen,
      ),
    );
  }

  static Widget builder(context, state) {
    var app = App.get();

    //app.pushStateToHistory(state);
    ////print(app.stateHistory)
    if (state is AppStateMainSplash) {
      AppTheme.setServicesTheme();
      return MainSplashScreen();
    }
    if (state is AppStateOnboarding) {
      return OnBoardingScreen();
    }
    if (state is AppStateAuthenticated) {
      //AppTheme.setStoreTheme();
      //context.pushStateToHistory(state);
      var data = DashboardScreenData(app);
      var screen = DashboardHomeScreen();
      return getAppScreenBlocBuilder<DashBoardViewModel>(
        screenData: data,
        screen: screen,
      );
    }
    if (state is StoreHomeScreenViewState) {
      AppTheme.setStoreTheme();
      //context.pushStateToHistory(state);
      var data = StoreScreenData(app);
      var screen = StoreHomeScreen();
      return getAppScreenBlocBuilder<StoreHomePageViewModel>(
        screenData: data,
        screen: screen,
      );
    }

    if (state is ServicesHomeScreenViewState) {
      AppTheme.setServicesTheme();
      //context.pushStateToHistory(state);
      var data = ServicesScreenData(app);
      var screen = ServicesHomeScreen();
      return getAppScreenBlocBuilder<ServicesHomeViewModel>(
        screenData: data,
        screen: screen,
      );
    }

    if (state is LandscapeHomeScreenViewState) {
      AppTheme.setLandscapeTheme();
      //context.pushStateToHistory(state);
      var data = LandscapeScreenData(app);
      var screen = LandscapeHomeScreen();
      return getAppScreenBlocBuilder<LandscapeHomeViewModel>(
        screenData: data,
        screen: screen,
      );
    }
    if (state is LandscapeAllServicesScreenViewState) {
      //context.pushStateToHistory(state);
      var data = LandscapeServicesScreenData(app);
      var screen = LandscapeAllServicesScreen();
      return getAppScreenBlocBuilder<CategoryCompactDto>(
        screenData: data,
        screen: screen,
      );
    }
    if (state is LandscapeProjectsScreenViewState) {
      //context.pushStateToHistory(state);
      var data = LandscapeProjectsScreenData(app);
      var screen = LandscapeProjectsScreen();
      return getAppScreenBlocBuilder<List<LandscapeProjectDto>>(
          screen: screen, screenData: data);
    }

    if (state is LandscapeServiceDetailScreenState) {
      //context.pushStateToHistory(state);
      var data = LandscapeServiceDetailScreenData(app, state.guid);
      var screen = LandscapeServiceDetailScreen();
      return getAppScreenBlocBuilder<LandscapeServiceDetailDto>(
        screenData: data,
        screen: screen,
      );
    }
    if (state is LandscapeProjectImagesScreenState) {
      //context.pushStateToHistory(state);
      var data = LandscapeProjectImagesScreenData(app, state.guid);
      var screen = LandscapeProjectImagesScreen(
        guid: state.guid,
      );
      return getAppScreenBlocBuilder<LandscapeProjectDto>(
        screenData: data,
        screen: screen,
      );
    }
    if (state is LandscapeAboutScreenState) {
      //context.pushStateToHistory(state);
      var screen = LandscapeAboutScreen();
      return getAppScreenBlocBuilder<Null>(
        screen: screen,
      );
    }
    if (state is ContactUsFormState) {
      //context.pushStateToHistory(state);
      var data = GetQuoteRequestScreenData(app);
      var screen = ContactUsForm();
      return getAppScreenBlocBuilder<bool>(screen: screen, screenData: data);
    }
    if (state is AppStateLogin) {
      //context.pushStateToHistory(state);
      var screen = LogInScreen();
      return getAppScreenBlocBuilder<bool>(screen: screen);
    }
    // if (state is AppStateChange) {
    //   context.pushStateToHistory(state.state);
    //   return state;
    // }
    // if (state is AppStateUnauthenticated) {
    //   //context.pushStateToHistory(state);
    //   return BackButtonWrapper(LogInScreen());
    // }
    if (state is AppStateSignUp) {
      //context.pushStateToHistory(state);
      return BackButtonWrapper(widget: SignUpScreen());
    }

    if (state is CategoryScreenViewState) {
      //context.pushStateToHistory(state);
      var data =
          CategoryScreenData(app, guid: state.guid, isService: state.isService);
      var screen = CategoryScreen(
        guid: state.guid,
        isSearch: state.isSearch,
        isService: state.isService,
        key: UniqueKey(),
      );
      return getAppScreenBlocBuilder<CategoryCompactDto>(
        screenData: data,
        screen: screen,
      );
    }

    if (state is StoreSearchState) {
      //context.pushStateToHistory(state);
      var screen = CategoryScreen(
        isSearch: true,
        key: UniqueKey(),
      );
      return getAppScreenBlocBuilder<CategoryCompactDto>(
        screen: screen,
      );
    }

    // if (state is CategoryProductsViewState) {
    //   //context.pushStateToHistory(state);
    //   return BackButtonWrapper(
    //       widget: CategoryProductsScreen(
    //           products: state.products, title: state.title));
    // }
    if (state is ProductDetailViewState) {
      //context.pushStateToHistory(state);
      var data = ProductDetailScreenData(app, guid: state.seName);
      var screen = ProductDetailPage(
        seName: state.seName,
        cartItemId: state.cartItemId,
        isCartProduct: state.isCartProduct,
      );
      return getAppScreenBlocBuilder<ProductDetailDto>(
          screen: screen, screenData: data);
      // return BlocProvider<AppBloc,AppState>(
      //   create: (context) => AppBloc),
      // );
      // return getProductBlocBuilder(state);
    }
    if (state is CartItemsViewState) {
      //context.pushStateToHistory(state);
      var data = CartItemsScreenData(app);
      var screen = CartItemsScreen();
      return getAppScreenBlocBuilder<bool>(screen: screen, screenData: data);
    }
    if (state is CartCheckoutViewState) {
      //context.pushStateToHistory(state);
      var data = CheckoutScreenData(app);
      var screen = CartCheckoutScreen();

      return getAppScreenBlocBuilder<bool>(screen: screen, screenData: data);
    }
    if (state is DirectCheckoutViewState) {
      //context.pushStateToHistory(state);
      // return BackButtonWrapper(widget: CheckoutPage());
      var data = CheckoutScreenData(app);
      var screen = DirectCheckoutScreen(
        addToCartDto: state.addToCartDto,
        product: state.product,
      );
      return getAppScreenBlocBuilder<CreateOrderResponseDto>(
          screen: screen, screenData: data);
    }
    if (state is OrdersViewState) {
      //context.pushStateToHistory(state);
      var data = CustomerOrdersScreenData(app);
      var screen = CustomerOrders();
      return getAppScreenBlocBuilder<bool>(screen: screen, screenData: data);
    }
    if (state is OrderDetailViewState) {
      //context.pushStateToHistory(state);
      var data = OrderDetailScreenData(app, state.orderId);
      var screen = OrderDetailScreen();
      return getAppScreenBlocBuilder<bool>(
          screen: screen, screenData: data, returnState: state.returnState);
      // //context.pushStateToHistory(state);
      // return BackButtonWrapper(
      //   widget: MyOrdersDetail(
      //     orderId: state.orderId,
      //     returnState: state.returnState,
      //   ),
      //   returnState: state.returnState,
      // );
    }
    if (state is CustomerProfileViewState) {
      //context.pushStateToHistory(state);
      var data = app.getRepo().token != null ? ProfileScreenData(app) : null;
      var screen =
          ProfileScreen(animationController: state.animationController);
      return getAppScreenBlocBuilder<bool>(
        screen: screen,
        screenData: data,
      );
    }
    if (state is EditProfileState) {
      //context.pushStateToHistory(state);
      var data = ProfileScreenData(app);
      var screen = ViewAndEditProfile();
      return getAppScreenBlocBuilder<bool>(screen: screen, screenData: data);
    }
    if (state is CustomerAddressesViewState) {
      //context.pushStateToHistory(state);
      var data = AddressesScreenData(app);
      var screen = CustomerAddress(
        addressType: state.addressType,
      );
      return getAppScreenBlocBuilder<bool>(screen: screen, screenData: data);
    }

    if (state is CreateOrEditAddressViewState) {
      //context.pushStateToHistory(state);
      // var data = EditAddressScreenData(app);
      var screen = CreateOrEditAddressScreen(
          returnState: state.returnState,
          address: state.address,
          addressType: state.addressType);
      return getAppScreenBlocBuilder<bool>(screen: screen);
    }

    if (state is PaymentMethodScreenViewState) {
      //context.pushStateToHistory(state);
      var screen = PaymentMethodScreen(
        orderId: state.orderId,
      );
      return getAppScreenBlocBuilder<bool>(
          screen: screen, returnState: state.returnState);
    }

    if (state is CardPaymentScreenViewState) {
      //context.pushStateToHistory(state);
      var screen = CardPaymentScreen(
        orderId: state.orderId,
      );

      return getAppScreenBlocBuilder<bool>(
        screen: screen,
      );
    }

    // if (state is VerifyCodeViewState) {
    //   return VerifyCodeScreen();
    // }
    if (state is AppStateLoading) {
      return LoadingScreen();
    }
    if (state is AppSplashStateStateLoading) {
      return MainSplashScreen(showLoading: true);
    }

    if (state is EmailOrPasswordVerificationScreenState) {
      //context.pushStateToHistory(state);
      var screen = EmailOrPasswordVerificationScreen(
          isEmail: state.isEmail, isChangePassword: state.isChangePassword);
      return getAppScreenBlocBuilder<bool>(screen: screen);
    }

    if (state is VerifyCodeScreenState) {
      //context.pushStateToHistory(state);
      var screen = VerifyCodeScreen();
      return getAppScreenBlocBuilder<bool>(screen: screen);
    }

    if (state is GalleryViewState) {
      //context.pushStateToHistory(state);
      var screen = GalleryViewScreen(
          title: state.title,
          imagePaths: state.imagePaths,
          currentIndex: state.currentIndex);
      return getAppScreenBlocBuilder<Null>(screen: screen);
    }

    return SplashScreen();
  }
}

// ignore: must_be_immutable
class ScreenWidget<T> extends StatefulWidget {
  final Widget screen;

  const ScreenWidget({Key key, this.screen}) : super(key: key);
  @override
  _ScreenWidgetState<T> createState() => _ScreenWidgetState<T>();
}

class _ScreenWidgetState<T> extends State<ScreenWidget<T>> with RouteAware {
  bool requestProcessed;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    App.get().routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  didPopNext() {
    ////print("===did pop next===");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppScreenBloc, AppScreenState>(
      // ignore: missing_return
      builder: (context, state) {
        var app = App.get();
        if (state is AppStateMainSplash) {
          app.isSplashRunning = true;
          AppTheme.setServicesTheme();
          return MainSplashScreen(
            showLoading: true,
          );
        }

        if (state is AppScreenUninitializedState) {
          if (app.authenticationCheckedOnAppStart == false) {
            app.isSplashRunning = true;
          }
          //print("===here 1====");
          if (App.get().isFirstTimeDataInitialization != true) {
            //print("FirstTimeDataInitializationStatus =====>");
            context.getAppScreenBloc().add(AppScreenLoadingEvent());
          } else {
            //print("FirstTimeDataInitializationStatus =====>");
            var tasks = [
              App.get().getRepo().getServiceRepository().getServicesHomeData,
              App.get().getRepo().getServiceRepository().getStoreHomeData,
              App.get()
                  .getRepo()
                  .getServiceRepository()
                  .getLandscapeHomeViewResponseModel,
              App.get()
                  .getRepo()
                  .getServiceRepository()
                  .getDashboardDataResponseModel,
              App.get()
                  .getRepo()
                  .getServiceRepository()
                  .getLandscapeProjectsResponseModel,
            ];
            // app.isFirstTimeDataInitialization = true;
            LocalStorageService.save(
              LocalStorageKeys.FirstTimeDataInitializationStatus,
              GeneralStrings.SET,
            ).then((value) {
              App.get().isFirstTimeDataInitialization = false;
            });
            //print("====here 2====");
            return TaskProgressScreen(tasks: tasks);
          }

          //print("====here 3====");
          if (app.isSplashRunning) {
            //print("====here 4====");
            return MainSplashScreen(showLoading: true);
          } else {
            //print("====here 5====");
            return LoadingScreen();
            // return BackButtonWrapper(widget: LoadingScreen());
          }
        }
        // if (state is TaskProgressScreenState) {
        //   //print("====task progress screen state==========");
        //   return TaskProgressScreen(tasks: state.tasks);
        // }
        if (state is AppScreenLoadingState) {
          //print("=======App screen loading state=========");
          if (app.isSplashRunning) {
            return MainSplashScreen(showLoading: true);
          } else {
            return LoadingScreen();
            // return BackButtonWrapper(widget: LoadingScreen());
          }
        }
        if (state is AppScreenSuccessState) {
          app.isSplashRunning = false;
          //print(app.stateHistory);
          ////print("return state ===> " + state.returnState.toString());
          var isGeneral = true;
          if (T == DashBoardViewModel) {
            //print("General Model");
            if (context.getAppBloc().isFirstTimeLoad) {
              //context.getAppBloc().isFirstTimeLoad = false;
            }
            isGeneral = false;
          }
          //print(isGeneral ? "TRUE" : "FALSE");
          //return widget.screen;
          if (!isGeneral) {
            return state.screen;
          }
          return BackButtonWrapper(
            widget: state.screen,
            returnState: state.returnState,
            isGeneral: isGeneral,
          );
        }
        if (state is AppScreenFailureState) {
          return ErrorScreen(
            error: state.str,
          );
        }
        if (state is AppScreenRequestSubmittedState) {
          ////print("isSubmitted");
        }
      },
    );
  }
}
