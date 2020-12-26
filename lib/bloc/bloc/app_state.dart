part of 'app_bloc.dart';

// ignore: must_be_immutable
abstract class AppState extends Equatable {
  AppState({this.requireAuthorization = false, this.returnState});

  @override
  List<Object> get props =>
      [this.requireAuthorization, this.returnState, this.rebuild];

  bool requireAuthorization = false;
  AppState returnState;
  Future<void> Function() rebuild;
}

// ignore: must_be_immutable
class AppStateUninitialized extends AppState {}

// ignore: must_be_immutable
class AppStateAuthenticated extends AppState {}

// ignore: must_be_immutable
class AppStateUnauthenticated extends AppState {}

// ignore: must_be_immutable
class AppStateSignUp extends AppState {
  AppStateSignUp({AppState returnState})
      : super(returnState: returnState ?? AppStateAuthenticated());
}

// ignore: must_be_immutable
class AppStateLogin extends AppState {
  AppStateLogin({AppState returnState})
      : super(returnState: returnState ?? AppStateAuthenticated());
}

// ignore: must_be_immutable
class AppStateLoading extends AppState {}

// ignore: must_be_immutable
class AppSplashStateStateLoading extends AppState {}

// ignore: must_be_immutable
class CategoryScreenViewState extends AppState {
  final String guid;
  final bool isSearch;
  final bool isService;
  CategoryScreenViewState({this.guid, this.isSearch, this.isService});
  @override
  List<Object> get props => [this.guid];
}

// ignore: must_be_immutable
class StoreHomeScreenViewState extends AppState {}

// ignore: must_be_immutable
class ServicesHomeScreenViewState extends AppState {}

// ignore: must_be_immutable
class LandscapeHomeScreenViewState extends AppState {}

// ignore: must_be_immutable
class LandscapeAllServicesScreenViewState extends AppState {}

// ignore: must_be_immutable
class LandscapeProjectsScreenViewState extends AppState {}

// ignore: must_be_immutable
class LandscapeServiceDetailScreenState extends AppState {
  final String guid;
  LandscapeServiceDetailScreenState({this.guid});
}

// ignore: must_be_immutable
class LandscapeProjectImagesScreenState extends AppState {
  final String guid;
  LandscapeProjectImagesScreenState({this.guid});
}

// ignore: must_be_immutable
class LandscapeAboutScreenState extends AppState {}

// ignore: must_be_immutable
class ContactUsFormState extends AppState {}

// ignore: must_be_immutable
class CategoryProductsViewState extends AppState {
  final List<ProductDto> products;
  final String title;
  CategoryProductsViewState({this.title, this.products});
}

// ignore: must_be_immutable
class ProductDetailViewState extends AppState {
  final String seName;
  final int cartItemId;
  final bool isCartProduct;
  ProductDetailViewState({this.seName, this.isCartProduct, this.cartItemId});
}

// ignore: must_be_immutable
class CartItemsViewState extends AppState {
  CartItemsViewState() : super(requireAuthorization: true);
}

// ignore: must_be_immutable
class CartCheckoutViewState extends AppState {}

// ignore: must_be_immutable
class DirectCheckoutViewState extends AppState {
  AddToCartDto addToCartDto;
  ProductDto product;
  DirectCheckoutViewState({this.addToCartDto, this.product});
}

// ignore: must_be_immutable
class PaymentMethodViewState extends AppState {}

// ignore: must_be_immutable
class AppStateChange extends AppState {
  final AppState state;
  AppStateChange(this.state);
}

// ignore: must_be_immutable
class OrdersViewState extends AppState {}

// ignore: must_be_immutable
class OrderDetailViewState extends AppState {
  final int orderId;
  final AppState returnState;
  final bool moveToPayment;
  OrderDetailViewState({
    this.orderId,
    this.returnState,
    this.moveToPayment = false,
  });
}

// ignore: must_be_immutable
class CustomerProfileViewState extends AppState {
  final int tabIndex;
  final AnimationController animationController;
  CustomerProfileViewState({this.tabIndex, this.animationController});
}

// ignore: must_be_immutable
class EditProfileState extends AppState {}

// ignore: must_be_immutable
class CustomerAddressesViewState extends AppState {
  final AddressType addressType;
  CustomerAddressesViewState({this.addressType});
}

// ignore: must_be_immutable
class CreateOrEditAddressViewState extends AppState {
  CustomerAddressDto address;
  AddressType addressType;
  AppState returnState;
  CreateOrEditAddressViewState(
      {this.address, this.addressType, this.returnState});
}

// ignore: must_be_immutable
class VerifyCodeViewState extends AppState {}

// ignore: must_be_immutable
class PaymentMethodScreenViewState extends AppState {
  final int orderId;
  final AppState returnState;
  PaymentMethodScreenViewState({this.orderId, this.returnState});
}

// ignore: must_be_immutable
class CardPaymentScreenViewState extends AppState {
  final int orderId;
  CardPaymentScreenViewState({this.orderId});
}

// ignore: must_be_immutable
class StoreSearchState extends AppState {
  final bool showFilterIcon;
  StoreSearchState({this.showFilterIcon});
}

// ignore: must_be_immutable
class EmailOrPasswordVerificationScreenState extends AppState {
  final bool isEmail;
  final bool isChangePassword;
  EmailOrPasswordVerificationScreenState({this.isEmail, this.isChangePassword});
}

// ignore: must_be_immutable
class VerifyCodeScreenState extends AppState {}

// ignore: must_be_immutable
class GalleryViewState extends AppState {
  final int currentIndex;
  final String title;
  final List<String> imagePaths;
  GalleryViewState({this.title, this.imagePaths, this.currentIndex});
}

// ignore: must_be_immutable
