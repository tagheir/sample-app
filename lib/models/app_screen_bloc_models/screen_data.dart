import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/models/addToCart_dto.dart';
import 'package:bluebellapp/models/address_enum.dart';
import 'package:bluebellapp/models/authResponse_dto.dart';
import 'package:bluebellapp/models/banner_dto.dart';
import 'package:bluebellapp/models/checkout_model.dart';
import 'package:bluebellapp/models/contact_us_dto.dart';
import 'package:bluebellapp/models/create_order_response.dart';
import 'package:bluebellapp/models/dashboard_view_model.dart';
import 'package:bluebellapp/models/homeViewModel.dart';
import 'package:bluebellapp/models/landscape_project_dto.dart';
import 'package:bluebellapp/models/landscape_service_detail_dto.dart';
import 'package:bluebellapp/models/order_compact_dto.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/update_cart_dto.dart';
import 'package:bluebellapp/services/database/database_network_table_service.dart';

import '../category_compact_dto.dart';
import '../category_filter_dto.dart';
import '../customerAddress_dto.dart';
import '../customer_dto.dart';
import '../landscapeHomeViewModel.dart';
import '../order_detail_dto.dart';
import '../response_model.dart';
import '../shoppingCart_dto.dart';
import '../storeHomeViewModel.dart';

abstract class ScreenData<T> {
  Future<ResponseModel<T>> getScreenData();
  // ignore: close_sinks
  App appBloc;
}

class DashboardScreenData extends ScreenData<DashBoardViewModel> {
  DashboardScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  @override
  Future<ResponseModel<DashBoardViewModel>> getScreenData() async {
    // var dashBoardViewModal = await appBloc
    //     .getRepo()
    //     .getServiceRepository()
    //     .getDashboardDataResponseModel();
    // print(dashBoardViewModal.data.toJson());
    DatabaseNetworkTableService.printAuthorized().then((value) => null);
    var dashBoardViewModal =
        ResponseModel<DashBoardViewModel>(data: null, success: true);
    dashBoardViewModal.data = DashBoardViewModel(banners: [
      BannerDto(
          seName: "facilities-management", title: "Facilities Management"),
      BannerDto(seName: "landscape", title: "Landscape"),
      BannerDto(seName: "smart-home-products", title: "eStore"),
    ]);
    LandscapeScreenData(appBloc)
        .getScreenData(setLandscapeImagesPath: true)
        .then((value) => null);
    ServicesScreenData(appBloc)
        .getScreenData(setLandscapeImagesPath: true)
        .then((value) => null);
    StoreScreenData(appBloc)
        .getScreenData(setLandscapeImagesPath: true)
        .then((value) => null);
    //await dashBoardViewModal?.data?.setBannersImagesPath();
    return dashBoardViewModal;
  }
}

class LandscapeScreenData extends ScreenData<LandscapeHomeViewModel> {
  LandscapeScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  @override
  Future<ResponseModel<LandscapeHomeViewModel>> getScreenData(
      {String guid, bool setLandscapeImagesPath = false}) async {
    var landscapeHomeViewModel = await appBloc
        .getRepo()
        .getServiceRepository()
        .getLandscapeHomeViewResponseModel();
    if (setLandscapeImagesPath == true &&
        landscapeHomeViewModel?.data != null) {
      landscapeHomeViewModel.data
          .setLandscapeImagesPath()
          .then((value) => null);
    }
    return landscapeHomeViewModel;
  }
}

class LandscapeServicesScreenData extends ScreenData<CategoryCompactDto> {
  LandscapeServicesScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  @override
  Future<ResponseModel<CategoryCompactDto>> getScreenData() async {
    var landscapeServicesViewModel = await appBloc
        .getRepo()
        .getServiceRepository()
        .getLandscapeServicesResponseModel();

    //await landscapeServicesViewModel?.data?.setProductsImagesPath();
    return landscapeServicesViewModel;
  }
}

class LandscapeProjectsScreenData
    extends ScreenData<List<LandscapeProjectDto>> {
  LandscapeProjectsScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  @override
  Future<ResponseModel<List<LandscapeProjectDto>>> getScreenData() async {
    var landscapeProjectsViewModel = await appBloc
        .getRepo()
        .getServiceRepository()
        .getLandscapeProjectsResponseModel();

    landscapeProjectsViewModel.data =
        await LandscapeProjectDto.setProjectsImagesPath(
            landscapeProjectsViewModel.data);
    return landscapeProjectsViewModel;
  }
}

class LandscapeProjectImagesScreenData extends ScreenData<LandscapeProjectDto> {
  LandscapeProjectImagesScreenData(App appBloc, String projectId) {
    this.appBloc = appBloc;
    this.projectId = projectId;
  }
  String projectId;
  @override
  Future<ResponseModel<LandscapeProjectDto>> getScreenData() async {
    var landscapeProjectImagesViewModel = await appBloc
        .getRepo()
        .getServiceRepository()
        .getLandscapeProjectsByIdResponseModel(projectId: projectId);

    await landscapeProjectImagesViewModel?.data?.setProjectImagesPath();
    return landscapeProjectImagesViewModel;
  }
}

class ProductDetailScreenData extends ScreenData<ProductDetailDto> {
  ProductDetailScreenData(App appBloc, {String guid}) {
    this.appBloc = appBloc;
    this.guid = guid;
  }
  String guid;
  AddToCartDto addToCartDto;

  @override
  Future<ResponseModel<ProductDetailDto>> getScreenData() async {
    var productDetailDto = await appBloc
        .getRepo()
        .getServiceRepository()
        .getProductDetailResponseModelByGuid(guid: guid);
    //await productDetailDto?.data?.setProductImagePath();
    return productDetailDto;
  }

  Future<ResponseModel<ShoppingCartDto>> addProductToCart() async {
    var cartDto = await appBloc
        .getRepo()
        .getCartRepository()
        .addToCart(cart: addToCartDto);
    return cartDto;
  }

  Future<ResponseModel<UpdateCartDto>> updateCartProduct() async {
    var cartDto = await appBloc
        .getRepo()
        .getCartRepository()
        .updateCart(cart: addToCartDto);
    return cartDto;
  }
}

class LandscapeServiceDetailScreenData
    extends ScreenData<LandscapeServiceDetailDto> {
  LandscapeServiceDetailScreenData(App appBloc, String guid) {
    this.appBloc = appBloc;
    this.guid = guid;
  }
  String guid;

  @override
  Future<ResponseModel<LandscapeServiceDetailDto>> getScreenData() async {
    var serviceDetailDto = await appBloc
        .getRepo()
        .getServiceRepository()
        .getLandscapeServiceDetailResponseModel(guid: guid);
    //await serviceDetailDto?.data?.setImagesPath();
    return serviceDetailDto;
  }
}

class GetQuoteRequestScreenData extends ScreenData<bool> {
  GetQuoteRequestScreenData(App appBloc, {ContactUsDto contactUsDto}) {
    this.contactUsDto = contactUsDto;
    this.appBloc = appBloc;
  }

  ContactUsDto contactUsDto;

  @override
  Future<ResponseModel<bool>> getScreenData() async {
    return ResponseModel<bool>(data: true, success: true);
  }

  Future<ResponseModel<bool>> submitQuote() async {
    var value = appBloc
        .getRepo()
        .getServiceRepository()
        .getQuoteResponseModel(contactUs: contactUsDto);
    return value;
  }
}

class StoreScreenData extends ScreenData<StoreHomePageViewModel> {
  StoreScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  @override
  Future<ResponseModel<StoreHomePageViewModel>> getScreenData(
      {bool setLandscapeImagesPath = false}) async {
    var storeHomeViewModel =
        await appBloc.getRepo().getServiceRepository().getStoreHomeData();

    if (setLandscapeImagesPath == true && storeHomeViewModel?.data != null) {
      storeHomeViewModel.data.setImagesPath().then((value) => null);
    }
    return storeHomeViewModel;
  }
}

class ServicesScreenData extends ScreenData<ServicesHomeViewModel> {
  ServicesScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  @override
  Future<ResponseModel<ServicesHomeViewModel>> getScreenData(
      {bool setLandscapeImagesPath = false}) async {
    var servicesHomeViewModel =
        await appBloc.getRepo().getServiceRepository().getServicesHomeData();
    if (setLandscapeImagesPath == true) {
      await servicesHomeViewModel.data.setImagesPath();
    }

    return servicesHomeViewModel;
  }
}

class CategoryScreenData extends ScreenData<CategoryFilterDto> {
  CategoryScreenData(App appBloc,
      {String guid,
      int pageNo,
      String searchQuery,
      String filterOptions,
      bool isService}) {
    this.appBloc = appBloc;
    this.guid = guid;
    this.isService = isService;
  }
  String guid;
  int pageNo;
  String searchQuery;
  String filteredOptions;
  bool isService;
  @override
  Future<ResponseModel<CategoryFilterDto>> getScreenData() async {
    print("isService => " + isService.toString());
    var categoryViewModel = await appBloc
        .getRepo()
        .getServiceRepository()
        .getCategoryDataWithProductFilters(
            categoryName: guid,
            search: searchQuery,
            pageNum: pageNo ?? 1,
            includeStats: isService == true ? false : true,
            filteredOptions: filteredOptions);
    // await categoryViewModel.data.setImagesPath();
    return categoryViewModel;
  }
}

class CartItemsScreenData extends ScreenData<ShoppingCartDto> {
  CartItemsScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  AddToCartDto cartDto;
  int cartItemId;
  @override
  Future<ResponseModel<ShoppingCartDto>> getScreenData() async {
    var cartItemsViewModel =
        await appBloc.getRepo().getCartRepository().getMyCart();
    return cartItemsViewModel;
  }

  Future<ResponseModel<UpdateCartDto>> upDateCart() async {
    var cart =
        await appBloc.getRepo().getCartRepository().updateCart(cart: cartDto);
    return cart;
  }

  Future<ResponseModel<ShoppingCartDto>> removeCartItem() async {
    var cart = await appBloc
        .getRepo()
        .getCartRepository()
        .removeItemFromCart(cartItemId: cartItemId);
    return cart;
  }
}

class CheckoutScreenData extends ScreenData<CheckoutModel> {
  CheckoutScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  CheckoutModel checkoutModel;

  @override
  Future<ResponseModel<CheckoutModel>> getScreenData() async {
    var checkoutModel =
        await appBloc.getRepo().getCartRepository().getCheckoutModel();
    return checkoutModel;
  }
}

class CheckoutCartScreenData extends ScreenData<int> {
  CheckoutCartScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  int billingAddressId;
  int orderId;
  int paymentMethod;
  AddToCartDto addToCartDto;
  @override
  getScreenData() {}

  Future<ResponseModel<int>> placeOrder() async {
    var placeOrder = await appBloc
        .getRepo()
        .getCartRepository()
        .placeOrder(billingAddressId: billingAddressId);

    // await categoryViewModel.data.setImagesPath();
    return placeOrder;
  }

  Future<ResponseModel<bool>> upDateOrderPaymentMethod() async {
    var placeOrder = await appBloc
        .getRepo()
        .getCartRepository()
        .updateOrderPaymentMethod(
            orderId: orderId, paymentMethod: paymentMethod);
    // await categoryViewModel.data.setImagesPath();
    return placeOrder;
  }

  Future<ResponseModel<CreateOrderResponseDto>> placeDirectOrder() async {
    var placeOrder = await appBloc
        .getRepo()
        .getCartRepository()
        .placeDirectOrder(cart: addToCartDto);

    // await categoryViewModel.data.setImagesPath();
    return placeOrder;
  }
}

class CustomerOrdersScreenData extends ScreenData<List<OrderCompactDto>> {
  CustomerOrdersScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  int pageNo;
  @override
  Future<ResponseModel<List<OrderCompactDto>>> getScreenData() async {
    var ordersViewModel = await appBloc
        .getRepo()
        .getCartRepository()
        .getMyOrders(pageNo: pageNo ?? 0);
    return ordersViewModel;
  }
}

class OrderDetailScreenData extends ScreenData<OrderDetailDto> {
  OrderDetailScreenData(App appBloc, int orderId) {
    this.appBloc = appBloc;
    this.orderId = orderId;
  }
  int orderId;
  @override
  Future<ResponseModel<OrderDetailDto>> getScreenData() async {
    var orderViewModel = await appBloc
        .getRepo()
        .getCartRepository()
        .getOrderDetail(orderId: orderId);
    return orderViewModel;
  }
}

class ProfileScreenData extends ScreenData<CustomerDto> {
  ProfileScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  CustomerDto customerDto;

  @override
  Future<ResponseModel<CustomerDto>> getScreenData() async {
    print("<CustomerDto>> getScreenData()");
    var profileInfo =
        await appBloc.getRepo().getUserRepository().getProfileInfo();
    print(profileInfo.data.firstName);
    return profileInfo;
  }

  Future<ResponseModel<CustomerDto>> updateCustomerInfo() async {
    var profileInfo = await appBloc
        .getRepo()
        .getUserRepository()
        .updateCustomerInfo(info: customerDto);
    return profileInfo;
  }
}

class AddressesScreenData extends ScreenData<List<CustomerAddressDto>> {
  AddressesScreenData(App appBloc) {
    this.appBloc = appBloc;
  }

  CustomerAddressDto customerAddress;
  AddressType addressType;

  @override
  Future<ResponseModel<List<CustomerAddressDto>>> getScreenData() async {
    var addresses =
        await appBloc.getRepo().getUserRepository().getCustomerAddresses();
    return addresses;
  }

  Future<ResponseModel<bool>> upDateAddress() async {
    var isUpdated = await appBloc
        .getRepo()
        .getUserRepository()
        .editCustomerAddress(
            address: customerAddress, addressType: addressType);
    return isUpdated;
  }

  Future<ResponseModel<CustomerAddressDto>> getAddress() async {
    var addressDto = await appBloc
        .getRepo()
        .getUserRepository()
        .getBillingOrShippingAddress(addressType: addressType);
    return addressDto;
  }
}

class EditAddressScreenData extends ScreenData<List<CustomerAddressDto>> {
  EditAddressScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  CustomerAddressDto customerAddress;
  AddressType addressType;

  @override
  getScreenData() {}

  Future<ResponseModel<bool>> createOrEditAddress() {
    if (customerAddress.id != null && customerAddress.id > 0) {
      var isUpdated = appBloc.getRepo().getUserRepository().editCustomerAddress(
          address: customerAddress, addressType: addressType);
      return isUpdated;
    }
    var isUpdated = appBloc
        .getRepo()
        .getUserRepository()
        .addCustomerAddress(address: customerAddress, addressType: addressType);
    return isUpdated;
  }
}

class EmailOrPasswordVerificationScreenData
    extends ScreenData<AuthenticationResult> {
  EmailOrPasswordVerificationScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  String emailOrPassword;
  String oldPassword;
  String newPassword;
  @override
  Future<ResponseModel<AuthenticationResult>> getScreenData() async {}

  Future<ResponseModel<AuthenticationResult>> verifyEmail() async {
    var authResult = await appBloc
        .getRepo()
        .getUserRepository()
        .verifyEmailForForgotPassword(email: emailOrPassword);
    appBloc.getRepo().getUserRepository().userEmail = emailOrPassword;
    appBloc.getRepo().getUserRepository().verificationToken =
        authResult.data.token;
    return authResult;
  }

  Future<ResponseModel<AuthenticationResult>> resetPassword() async {
    var authResult = await appBloc
        .getRepo()
        .getUserRepository()
        .resetPassword(password: emailOrPassword);
    if (authResult?.data?.token != null) {
      appBloc.setAuthToken(authResult?.data?.token);
    }
    return authResult;
  }

  Future<ResponseModel<AuthenticationResult>> changePassword() async {
    var authResult = await appBloc
        .getRepo()
        .getUserRepository()
        .changePassword(oldPassword: oldPassword, newPassword: newPassword);
    return authResult;
  }
}

class VerifyCodeScreenData extends ScreenData<void> {
  VerifyCodeScreenData(App appBloc) {
    this.appBloc = appBloc;
  }
  String code;
  @override
  Future<ResponseModel<void>> getScreenData() async {}

  Future<ResponseModel<AuthenticationResult>> verifyCode() async {
    var authResult =
        await appBloc.getRepo().getUserRepository().verifyCode(code: code);
    appBloc.getRepo().getUserRepository().verificationToken =
        authResult.data.token;
    return authResult;
  }
}
