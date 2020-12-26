part of 'app_bloc.dart';

abstract class AppEvent {
  AppEvent({this.returnState});
  AppState returnState;
}

class AppStarted extends AppEvent {}

class DashboardScreenEvent extends AppEvent {}

class LoggedIn extends AppEvent {
  LoggedIn();

  @override
  List<Object> get props => [this.returnState];

  @override
  String toString() => 'LoggedIn';
}

class LoginButtonPressedEvent extends AppEvent {
  final LoginDto loginDto;
  final Function callBack;

  LoginButtonPressedEvent({
    @required this.loginDto,
    @required this.callBack,
    AppState returnState,
  }) : super(returnState: returnState ?? AppStateAuthenticated());

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Login button pressed';
}

class SignUpButtonPressedEvent extends AppEvent {
  final SignUpDto signUpDto;
  final Function callBack;

  SignUpButtonPressedEvent({
    @required this.signUpDto,
    @required this.callBack,
    AppState returnState,
  }) : super(returnState: returnState);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Signup button pressed';
}

class LoginScreenEvent extends AppEvent {}

class LoggedOut extends AppEvent {}

class CategoryScreenEvent extends AppEvent {
  final String guid;
  final bool isSearch;
  final bool isService;
  CategoryScreenEvent({this.guid, this.isSearch, this.isService});
}

class CategoryProductsViewEvent extends AppEvent {
  final List<ProductDto> products;
  final CategoryDto category;
  CategoryProductsViewEvent({
    this.category,
    this.products,
  });
}

class StoreSearchEvent extends AppEvent {}

class ProductDetailViewEvent extends AppEvent {
  final String seName;
  final int cartItemId;
  final bool isCardProduct;
  ProductDetailViewEvent({this.seName, this.isCardProduct, this.cartItemId});
}

class CartCheckoutViewEvent extends AppEvent {}

class DirectCheckoutViewEvent extends AppEvent {
  AddToCartDto addToCartDto;
  ProductDto prod;
  DirectCheckoutViewEvent({this.addToCartDto, this.prod});
}

class PaymentMethodViewEvent extends AppEvent {}

class CartItemsViewEvent extends AppEvent {}

class OrdersViewEvent extends AppEvent {}

class SignUpEvent extends AppEvent {}

class ForgotPasswordEvent extends AppEvent {}

class OrderDetailViewEvent extends AppEvent {
  final int orderId;
  final AppState returnState;
  final bool moveToPayment;

  OrderDetailViewEvent({
    this.orderId,
    this.returnState,
    this.moveToPayment = false,
  });
}

class StateEvent extends AppEvent {
  final AppState state;

  StateEvent(this.state);
}

class StoreHomeScreenEvent extends AppEvent {}

class ServicesHomeScreenEvent extends AppEvent {}

class LandscapeHomeScreenEvent extends AppEvent {}

class LandscapeAllServicesScreenEvent extends AppEvent {}

class LandscapeProjectsScreenViewEvent extends AppEvent {}

class LandscapeServiceDetailScreenEvent extends AppEvent {
  final String guid;
  LandscapeServiceDetailScreenEvent({this.guid});
}

class LandscapeProjectImagesScreenEvent extends AppEvent {
  final String guid;
  LandscapeProjectImagesScreenEvent({this.guid});
}

class ContactUsFormScreenEvent extends AppEvent {}

class LandscapeAboutScreenEvent extends AppEvent {}

class CustomerProfileViewEvent extends AppEvent {
  final int tabIndex;
  AnimationController animationController;
  CustomerProfileViewEvent({this.tabIndex, this.animationController});

  @override
  String toString() => 'Profile Event { token: $tabIndex }';
}

class EditProfileEvent extends AppEvent {}

class CustomerAddressesViewEvent extends AppEvent {
  final AddressType addressType;
  CustomerAddressesViewEvent({this.addressType});
}

class CustomerAllAddressesViewEvent extends AppEvent {
  CustomerAllAddressesViewEvent();
}

class CreateOrEditAddressViewEvent extends AppEvent {
  CustomerAddressDto address;
  AddressType addressType;
  AppState returnState;
  CreateOrEditAddressViewEvent(
      {this.address, this.addressType, this.returnState});
}

class VerifyCodeViewEvent extends AppEvent {}

class VerifyCodeButtonPressed extends AppEvent {
  final String code;
  final Function(String) callBack;
  VerifyCodeButtonPressed({this.code, this.callBack});
}

class PaymentMethodScreenViewEvent extends AppEvent {
  final int orderId;
  final AppState returnState;
  PaymentMethodScreenViewEvent({this.orderId, this.returnState});
}

class CardPaymentScreenViewEvent extends AppEvent {
  final int orderId;
  CardPaymentScreenViewEvent({this.orderId});
}

class EmailOrPasswordVerificationScreenEvent extends AppEvent {
  final bool isEmail;
  final bool isChangePassword;
  EmailOrPasswordVerificationScreenEvent({this.isEmail, this.isChangePassword});
}

class VerifyCodeScreenEvent extends AppEvent {}

class GalleryViewEvent extends AppEvent {
  final int currentIndex;
  final String title;
  final List<String> imagePaths;
  GalleryViewEvent({this.title, this.imagePaths, this.currentIndex});
}
