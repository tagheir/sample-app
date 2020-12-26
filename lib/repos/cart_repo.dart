import 'dart:convert';

import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/addToCart_dto.dart';
import 'package:bluebellapp/models/checkout_model.dart';
import 'package:bluebellapp/models/order_compact_dto.dart';
import 'package:bluebellapp/models/order_detail_dto.dart';
import 'package:bluebellapp/models/order_item_dto.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/product_attribute_dto.dart';
import 'package:bluebellapp/models/response_model.dart';
import 'package:bluebellapp/models/shoppingCart_dto.dart';
import 'package:bluebellapp/models/create_order_response.dart';
import 'package:bluebellapp/models/update_cart_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/attribute_control_type.dart';
import 'package:bluebellapp/resources/constants/helper_constants/network_request_type.dart';
import 'package:bluebellapp/services/authorize_network_service.dart';
import 'package:bluebellapp/services/database/database_network_table_service.dart';

class CartRepository {
  final App app;
  AuthorizeNetworkService authorizeNetworkService;
  CartRepository({this.app}) {
    this.authorizeNetworkService = app.getRepo().getNetworkService();
  }
  AuthorizeNetworkService getAuthorizeNetworkService() {
    if (authorizeNetworkService == null) {
      authorizeNetworkService = app.getRepo().getNetworkService();
    }
    return authorizeNetworkService;
  }

  ShoppingCartDto myCart = ShoppingCartDto();
  List<OrderCompactDto> myOrders = List<OrderDetailDto>();
  List<ProductDetailDto> cartItems = List<ProductDetailDto>();
  int myCartCount = 0;
  int myOrdersCount = 0;

  //===============================Cart ===========================================

  Future<ResponseModel<ShoppingCartDto>> addToCart(
      {AddToCartDto cart, Function callBack}) async {
    if (app.getRepo().getToken() == null) {
      app.add(LoginScreenEvent());
    } else {
      var url = "${Cart.CartBase}/${cart.productId}/1/${cart.quantity}";
      var model = AttrMap.encodeList(attr: cart.form);
      var response =
          await getAuthorizeNetworkService().process<ShoppingCartDto>(
        model: model,
        endPoint: url,
        networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
        parser: (data) => ShoppingCartDto.fromJson(data),
      );
      ////print(response.data);
      updateForceCart(removeOldCart: true, removeOldCheckout: true)
          .then((value) => null);
      return ResponseModel.processResponse(response: response);
    }
    return null;
  }

  Future<ResponseModel<UpdateCartDto>> updateCart(
      {AddToCartDto cart, Function callBack}) async {
    if (app.getRepo().getToken() == null) {
      app.add(LoginScreenEvent());
      return Future.value(null);
    } else {
      var url = Cart.UpdateCart;
      var model = cart.toJson();
      ////print(model);
      //var model = AttrMap.encodeList(attr: cart.form);
      var response = await getAuthorizeNetworkService().process<UpdateCartDto>(
        endPoint: url,
        model: model,
        networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
        parser: (data) => UpdateCartDto.fromJson(data),
      );
      updateForceCart(removeOldCart: true, removeOldCheckout: true)
          .then((value) => null);
      return ResponseModel.processResponse(response: response);
    }
  }

  Future<ShoppingCartDto> shoppingCartResponseHelper(
      ResponseModel<ShoppingCartResponse> response, Function callBack) {
    if (ResponseModel.processFailure(response, callBack) == false) {
      myCart = response.data.shoppingCart;
      myCartCount = response?.data?.shoppingCart?.totalQuantity ?? 0;
    }
    ResponseModel.processResponse(response: response);
    return Future.value(response?.data?.shoppingCart);
  }

  Future<ResponseModel<ShoppingCartDto>> removeItemFromCart(
      {Function callBack, int cartItemId}) async {
    var url = Cart.CartBase + "/deleteItem/" + cartItemId.toString();
    var response = await getAuthorizeNetworkService().process<ShoppingCartDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_AUTHORIZED_JSON,
      parser: (data) => ShoppingCartDto.fromJson(data),
    );
    updateForceCart(removeOldCart: true, removeOldCheckout: true)
        .then((value) => null);
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<ShoppingCartDto>> getMyCart(
      {Function callBack, bool forceNetwork = false}) async {
    var url = Cart.CartBase;
    var response = await getAuthorizeNetworkService().process<ShoppingCartDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_AUTHORIZED_JSON,
      parser: (data) => ShoppingCartDto.fromJson(data),
      saveLocal: true,
      age: 1,
      forceNetwork: forceNetwork,
    );
    if (forceNetwork == false) {
      updateForceCart().then((value) => null);
    }
    return ResponseModel.processResponse(response: response);
  }

  Future<void> updateForceCart(
      {bool removeOldCart = false, bool removeOldCheckout = false}) {
    if (removeOldCart) DatabaseNetworkTableService.delete(Cart.CartBase);

    if (removeOldCheckout)
      DatabaseNetworkTableService.delete(Cart.GetCheckoutModel);

    getMyCart(forceNetwork: true).then((value) => null);
    getCheckoutModel(forceNetwork: true).then((value) => null);
    return Future.value(null);
  }

  Future<ResponseModel<CheckoutModel>> getCheckoutModel(
      {Function callBack, bool forceNetwork = false}) async {
    var url = Cart.GetCheckoutModel;
    var response = await getAuthorizeNetworkService().process<CheckoutModel>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_AUTHORIZED_JSON,
      parser: (data) => CheckoutModel.fromJson(data),
      saveLocal: true,
      age: 1,
      forceNetwork: forceNetwork,
    );
    if (forceNetwork == false) {
      updateForceCart().then((value) => null);
    }
    return ResponseModel.processResponse(response: response);
  }

  Future<ShoppingCartDto> shoppingCartDtoResponseHelper(
      ResponseModel<ShoppingCartDto> response, Function callBack) {
    if (ResponseModel.processFailure(response, callBack) == false) {
      myCart = response.data;
      myCartCount = response?.data?.totalQuantity ?? 0;
    }
    return Future.value(response?.data);
  }

  Future<int> getCartItemsCount() async {
    if (myCartCount <= 0) {
      await getMyCart();
    }
    return myCartCount;
  }

  Future<ProductCompactAttribute> getDropDownAttributeValue(
      {int productId}) async {
    var cartItems = await getMyCart();
    var cartItem = cartItems.data.shoppingCartItems.firstWhere(
        (s) => s.productId.toString() == productId.toString(),
        orElse: () => null);
    var dropDownAttr = cartItem.productAttributes.firstWhere(
        (p) => p?.name == AttributeType.DropdownList,
        orElse: () => null);
    if (dropDownAttr != null) {
      return Future.value(dropDownAttr);
    } else {
      return null;
    }
  }

  Future<String> getDateAttributeValue({int productId}) async {
    var cartItems = await getMyCart();
    var cartItem = cartItems.data.shoppingCartItems
        .firstWhere((s) => s.productId == productId, orElse: () => null);
    var dropDownAttr = cartItem.productAttributes.firstWhere(
        (p) => p?.name == AttributeType.ServiceDate,
        orElse: () => null);
    if (dropDownAttr != null) {
      return Future.value(dropDownAttr.value);
    } else {
      return null;
    }
  }

  //=============================Order===============================

  Future<ResponseModel<CreateOrderResponseDto>> placeDirectOrder(
      {AddToCartDto cart, Function callBack, int billingAddressId}) async {
    var url = "${Order.CreateDirectOrder}/${cart.productId.toString()}";
    //print(url);
    var model = AttrMap.encodeList(attr: cart.form);
    //print(model.toString());
    var response = await getAuthorizeNetworkService()
        .process<CreateOrderResponseDto>(
            model: model,
            endPoint: url,
            networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
            parser: (data) => CreateOrderResponseDto.fromJson(data));
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<bool>> updateOrderPaymentMethod(
      {int orderId, int paymentMethod}) async {
    var url = Order.UpdateOrderPaymentMethod.replaceAll(
        'orderId', orderId.toString());
    url = url.replaceAll('methodType', paymentMethod.toString());
    var response = await getAuthorizeNetworkService().process<bool>(
      endPoint: url,
      networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
      parser: (data) => data,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<int>> placeOrder(
      {Function callBack, int billingAddressId}) async {
    var url = Order.CreateOrderByShoppingCart;

    var response = await getAuthorizeNetworkService().process<int>(
      endPoint: url,
      networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
      parser: (data) => (int.tryParse(data.toString()) ?? 0),
    );
    updateForceCart().then((value) => null);
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<List<OrderCompactDto>>> getMyOrders(
      {int pageNo, bool forceNetwork = false}) async {
    var url = Order.GetCustomerOrder + pageNo.toString();
    var response =
        await getAuthorizeNetworkService().process<List<OrderCompactDto>>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_AUTHORIZED_JSON,
      parser: (data) => OrderCompactDto.parseJsonList(data),
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<OrderDetailDto>> getOrderDetail(
      {Function callBack, int orderId, bool forceNetwork = false}) async {
    var url = Order.GetOrderById;
    url = url.replaceAll('{orderId}', orderId.toString());
    //////print(url);
    var response = await getAuthorizeNetworkService().process<OrderDetailDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_AUTHORIZED_JSON,
      parser: (data) => OrderDetailDto.fromJson(data),
    );
    return ResponseModel.processResponse(response: response);
    ;
  }

  Future<String> getOrderItemDropDownValue({OrderItem orderItem}) async {
    // var dropAttr = orderItem?.attributes?.productAttribute?.firstWhere(
    //     (p) =>
    //         p?.productAttributeValue?.attributeType ==
    //         AttributeType.DropdownList,
    //     orElse: () => null);
    // var attrVal = dropAttr?.productAttributeValue?.attributeValue;
    // if (attrVal != null) {
    //   return Future.value(attrVal);
    // }
    return null;
  }

  Future<String> getOrderItemDateValue({OrderItem orderItem}) async {
    // var dropAttr = orderItem?.attributes?.productAttribute?.firstWhere(
    //     (p) =>
    //         p?.productAttributeValue?.attributeType ==
    //         AttributeType.ServiceDate,
    //     orElse: () => null);
    // var attrVal = dropAttr?.productAttributeValue?.value;
    // if (attrVal != null) {
    //   return Future.value(attrVal);
    // }
    return null;
  }

  Future<int> getOrdersCount() async {
    if (myOrdersCount <= 0) {
      await getMyOrders();
    }
    return myOrdersCount;
  }
}
