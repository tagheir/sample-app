import 'dart:async';
// import 'dart:collection';
// import 'package:bloc/bloc.dart';
// import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/models/addToCart_dto.dart';
import 'package:bluebellapp/models/address_enum.dart';
import 'package:bluebellapp/models/category_dto.dart';
//import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/models/login_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/models/shoppingCart_dto.dart';
//import 'package:bluebellapp/models/response_model.dart';
import 'package:bluebellapp/models/signup_dto.dart';
// import 'package:bluebellapp/repos/app_repo.dart';
// import 'package:bluebellapp/resources/constants/general_constants.dart';
// import 'package:bluebellapp/resources/strings/general_string.dart';
// import 'package:bluebellapp/resources/strings/local_storage_keys.dart';
// import 'package:bluebellapp/resources/themes/theme.dart';
// import 'package:bluebellapp/services/local_storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
part 'app_event.dart';
part 'app_state.dart';

// class AppBloc extends Bloc<AppEvent, AppState> {
//   AppRepo appRepo;
//   GlobalKey<NavigatorState> navigatorKey;
//   Queue<AppState> stateHistory = Queue<AppState>();
//   bool authenticationCheckedOnAppStart = false;
//   bool isUserLoggedIn = false;
//   bool firstTimeLogin = true;
//   bool isFirstTimeLoad = true;
//   CategoryType categoryType = CategoryType.Store;

//   AppBloc(AppState initialState) : super(initialState);

//   AppRepo getRepo() {
//     if (appRepo == null) appRepo = AppRepo(App.get());
//     return appRepo;
//   }

//   @override
//   AppState get initialState => AppStateUninitialized();

//   @override
//   Stream<AppState> mapEventToState(
//     AppEvent event,
//   ) async* {
//     //////print(authenticationCheckedOnAppStart);
//     AppTheme.deductedHeight = 0.0;
//     AppTheme.deductedWidth = 0.0;
//     if (GeneralConstants.directoryPath == null) {
//       GeneralConstants.directoryPath =
//           (await getApplicationDocumentsDirectory()).path;
//       ////print("Directory Path => " + GeneralConstants.directoryPath);
//     }

//     if (event is AppStarted) {
//       yield AppStateAuthenticated();
//     }
//     if (event is DashboardScreenEvent) {
//       categoryType = CategoryType.Store;
//       AppTheme.setStoreTheme();
//       yield AppStateAuthenticated();
//     }
//     if (event is StoreHomeScreenEvent) {
//       categoryType = CategoryType.Store;
//       yield StoreHomeScreenViewState();
//     }
//     if (event is ServicesHomeScreenEvent) {
//       categoryType = CategoryType.FacilityManagement;
//       yield ServicesHomeScreenViewState();
//     }
//     if (event is LandscapeHomeScreenEvent) {
//       categoryType = CategoryType.Landscape;
//       AppTheme.setLandscapeTheme();
//       yield LandscapeHomeScreenViewState();
//     }
//     if (event is LandscapeAllServicesScreenEvent) {
//       yield LandscapeAllServicesScreenViewState();
//     }
//     if (event is LandscapeProjectsScreenViewEvent) {
//       yield LandscapeProjectsScreenViewState();
//     }
//     if (event is LandscapeServiceDetailScreenEvent) {
//       yield LandscapeServiceDetailScreenState(guid: event.guid);
//     }
//     if (event is LandscapeProjectImagesScreenEvent) {
//       yield LandscapeProjectImagesScreenState(guid: event.guid);
//     }
//     if (event is LandscapeAboutScreenEvent) {
//       yield LandscapeAboutScreenState();
//     }
//     if (event is ContactUsFormScreenEvent) {
//       yield ContactUsFormState();
//     }
//     if (event is LoginScreenEvent) {
//       yield AppStateLogin();
//       var status =
//           await LocalStorageService.get(LocalStorageKeys.FirstTimeLoginStatus);
//       if (status != null && firstTimeLogin == true) {
//         firstTimeLogin = false;
//       } else if (status == null) {
//         await LocalStorageService.save(
//             LocalStorageKeys.FirstTimeLoginStatus, GeneralStrings.SET);
//       }
//     }
//     if (event is LoginButtonPressedEvent) {
//       var response = await getRepo().getUserRepository().authenticate(
//             username: event.loginDto.email.trim(),
//             password: event.loginDto.password,
//           );
//       if (ResponseModel.processFailure(response, event.callBack)) {
//         if (response.isAuthorizationError ||
//             response.isAuthorizationTokenError) {
//           yield AppStateLogin();
//         }
//       }
//       if (response.data.errors.length > 0) {
//         event.callBack(response.data.errors.first);
//         //  yield AppStateLogin();
//       } else if (response.data.token != null) {
//         setAuthToken(response.data.token);
//         event.callBack(null);
//         yield AppStateAuthenticated();
//         // event.callBack(null);
//         // yield VerifyCodeViewState();
//       }
//     }

//     if (event is SignUpButtonPressedEvent) {
//       // yield AppStateLoading();
//       try {
//         var response =
//             await getRepo().getUserRepository().signUp(user: event.signUpDto);
//         ////print("response received======");
//         ////print(response.data.token);
//         if (ResponseModel.processFailure(response, event.callBack)) {
//           if (response.isAuthorizationError ||
//               response.isAuthorizationTokenError) {
//             yield AppStateSignUp();
//           }
//         } else if (response.data.errors.length > 0) {
//           if (response.data.errors.length > 0) {
//             event.callBack(response.data.errors.first);
//             //yield AppStateSignUp();
//           }
//         } else if (response.data.token != null) {
//           setAuthToken(response.data.token);
//           event.callBack(null);
//           yield AppStateAuthenticated();
//           // event.callBack(null);
//           // yield VerifyCodeViewState();
//         }
//       } catch (e) {
//         ////print(e.toString());
//       }
//     }

//     // Verify Code After Login Screen
//     if (event is VerifyCodeButtonPressed) {
//       var response = await getRepo()
//           .getUserRepository()
//           .generateTwoFactorAuthentication(code: event.code);
//       if (ResponseModel.processFailure(response, event.callBack)) {
//         if (response.isAuthorizationError ||
//             response.isAuthorizationTokenError) {
//           yield AppStateLogin();
//         }
//       } else if (response?.data?.errors != null) {
//         if (response.data.errors.length > 0) {
//           event.callBack(response.data.errors.first);
//           yield VerifyCodeViewState();
//         }
//       } else if (response.data.token != null) {
//         appRepo.token = response.data.token;
//         isUserLoggedIn = true;
//         await getRepo().getUserRepository().getCustomerInfo();
//         event.callBack(null);
//         yield AppStateAuthenticated();
//       }
//     }

//     // Login Event Called (legacy)
//     if (event is LoggedIn) {
//       yield AppStateLoading();
//       await getRepo().getUserRepository().getCustomerInfo();
//       yield AppStateAuthenticated();
//     }

//     if (event is CategoryScreenEvent) {
//       ////print("event===" + event.isService.toString());
//       yield CategoryScreenViewState(
//           guid: event.guid,
//           isSearch: event.isSearch,
//           isService: event.isService);
//     }
//     if (event is CategoryProductsViewEvent) {
//       yield CategoryProductsViewState(
//         products: event.products,
//         title: event?.category?.name ?? 'Products',
//       );
//     }
//     if (event is StoreSearchEvent) {
//       yield StoreSearchState();
//     }
//     // if (event is SearchEvent) {
//     //   yield AppStateLoading();
//     //   var products =
//     //       await appRepo.getServiceRepository().searchProducts(event.query);

//     //   yield CategoryProductsViewState(
//     //     products: products,
//     //     title: "Search \"" + event.query.trim() + "\"",
//     //   );
//     // }
//     if (event is CustomerAddressesViewEvent) {
//       yield CustomerAddressesViewState(addressType: event.addressType);
//     }
//     if (event is CustomerAllAddressesViewEvent) {
//       yield CustomerAddressesViewState();
//     }
//     if (event is CreateOrEditAddressViewEvent) {
//       yield CreateOrEditAddressViewState(
//           address: event.address,
//           addressType: event.addressType,
//           returnState: event.returnState);
//     }
//     if (event is ProductDetailViewEvent) {
//       yield ProductDetailViewState(
//           seName: event.seName,
//           isCartProduct: event.isCardProduct,
//           cartItemId: event.cartItemId);
//     }
//     if (event is CartItemsViewEvent) {
//       if (getRepo().getToken() != null) {
//         yield CartItemsViewState();
//       } else {
//         yield AppStateLogin();
//       }
//     }
//     if (event is CartCheckoutViewEvent) {
//       yield CartCheckoutViewState();
//     }
//     if (event is DirectCheckoutViewEvent) {
//       yield DirectCheckoutViewState(
//           addToCartDto: event.addToCartDto, product: event.prod);
//     }
//     if (event is PaymentMethodViewEvent) {
//       yield PaymentMethodViewState();
//     }
//     if (event is LoggedOut) {
//       yield AppStateLoading();
//       stateHistory.clear();
//       isUserLoggedIn = false;
//       getRepo().userRepository.deleteToken();
//       appRepo = null;
//       // await userRepository.deleteToken();
//       yield AppStateAuthenticated();
//     }
//     if (event is OrdersViewEvent) {
//       yield OrdersViewState();
//     }
//     if (event is SignUpEvent) {
//       yield AppStateSignUp();
//     }
//     if (event is StateEvent) {
//       yield event.state; //AppStateChange(event.state);
//     }
//     if (event is OrderDetailViewEvent) {
//       yield OrderDetailViewState(
//           orderId: event.orderId, returnState: event.returnState);
//     }
//     if (event is CustomerProfileViewEvent) {
//       yield CustomerProfileViewState(
//           tabIndex: event.tabIndex,
//           animationController: event.animationController);
//     }
//     if (event is EditProfileEvent) {
//       yield EditProfileState();
//     }
//     if (event is PaymentMethodScreenViewEvent) {
//       yield PaymentMethodScreenViewState(
//           orderId: event.orderId, returnState: event.returnState);
//     }
//     if (event is CardPaymentScreenViewEvent) {
//       yield CardPaymentScreenViewState(orderId: event.orderId);
//     }
//     if (event is VerifyCodeScreenEvent) {
//       yield VerifyCodeScreenState();
//     }
//     if (event is EmailOrPasswordVerificationScreenEvent) {
//       yield EmailOrPasswordVerificationScreenState(
//           isEmail: event.isEmail, isChangePassword: event.isChangePassword);
//     }
//     if (event is GalleryViewEvent) {
//       yield GalleryViewState(
//           title: event.title,
//           imagePaths: event.imagePaths,
//           currentIndex: event.currentIndex);
//     }
//   }

//   setAuthToken(String token) async {
//     appRepo.token = token;
//     isUserLoggedIn = true;
//     await getRepo().getUserRepository().persistToken(token: appRepo.token);
//   }

//   moveBack({AppState returnState}) {
//     if (stateHistory != null && stateHistory.length > 1) {
//       if (returnState == null) {
//         stateHistory.removeFirst();
//         var st = stateHistory.removeFirst();
//         if (st == null) {
//           this.add(StateEvent(AppStateAuthenticated()));
//         } else {
//           this.add(StateEvent(st));
//         }
//       } else {
//         int count = 0;
//         bool isStateExist = false;
//         for (var st in stateHistory) {
//           //////print(st.toString());
//           //////print("state===>"+ (st == returnState).toString());
//           if (st == returnState) {
//             //////print("state exis===>" + isStateExist.toString());
//             isStateExist = true;
//             break;
//           } else {
//             count += 1;
//           }
//         }
//         var currentState;
//         if (isStateExist == true) {
//           for (int i = 0; i < count; i++) {
//             currentState = stateHistory.removeFirst();
//           }
//           if (stateHistory.length >= 1) {
//             //////print("=============return state===========");
//             currentState = stateHistory.removeFirst();
//             //////print("=============return state===========");
//             //////print(currentState);
//             if (currentState == returnState) {
//               //////print("=============return state===========");
//               //////print(currentState);
//               this.add(StateEvent(returnState));
//             }
//           }
//         }
//       }
//     } else if (stateHistory != null && stateHistory.length > 0) {
//       if (returnState == null) {
//         var state = stateHistory.removeFirst();
//         this.add(StateEvent(state));
//       } else {
//         this.add(StateEvent(AppStateAuthenticated()));
//       }
//     }
//   }

//   pushStateToHistory(AppState state) {
//     // if (stateHistory == null) stateHistory = Queue<AppState>();
//     // stateHistory.addFirst(state);
//     // if (navigatorKey != null) {
//     //   navigatorKey.
//     // }
//   }
//}
