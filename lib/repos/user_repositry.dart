import 'dart:convert';

import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/models/address_enum.dart';
import 'package:bluebellapp/models/authResponse_dto.dart';
import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/models/customer_dto.dart';
import 'package:bluebellapp/models/response_model.dart';
import 'package:bluebellapp/models/signup_dto.dart';
import 'package:bluebellapp/models/twoFactorAuth_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/network_request_type.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/services/authorize_network_service.dart';
import 'package:bluebellapp/services/database/database_network_table_service.dart';
import 'package:bluebellapp/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final App app;
  AuthorizeNetworkService authorizeNetworkService;
  CustomerAddressDto customerBillingAddress;
  CustomerAddressDto customerShippingAddress;
  String userEmail;
  String verificationToken;
  UserRepository({this.app}) {
    authorizeNetworkService = app.getRepo().getNetworkService();
  }

  //final storage = FlutterSecureStorage();
  static const String AUTH_TOKEN = GeneralStrings.AUTH_TOKEN;
  static const String AUTH_REFRESH_TOKEN = GeneralStrings.AUTH_REFRESH_TOKEN;
  CustomerDto profileInfo;
  List<CustomerAddressDto> myAddresses;
  TwoFactorAuthDto twoFactorAuthDto = TwoFactorAuthDto();
  String userVerificationToken;

  Future<ResponseModel<AuthenticationResult>> authenticate({
    @required String username,
    @required String password,
  }) async {
    var data = username.contains('@')
        ? json.encode({"nickname": username, "password": password})
        : json.encode({"phonenumber": username});
    var url = username.contains('@') ? ApiRoutes.Login : ApiRoutes.LoginWithP;
    try {
      var response =
          await authorizeNetworkService.process<AuthenticationResult>(
              endPoint: url,
              model: data,
              networkRequestType: NetworkRequestType.POST_JSON,
              parser: (data) => AuthenticationResult.fromJson(data));
      if (response?.data != null && response.success == true) {
        twoFactorAuthDto = TwoFactorAuthDto(
          userVerificationToken: response.data.token,
          emailOrPhoneNumber: username,
        );
      }
      return Future.value(response);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<ResponseModel<AuthenticationResult>> signUp({SignUpDto user}) async {
    try {
      var response =
          await authorizeNetworkService.process<AuthenticationResult>(
              endPoint: ApiRoutes.Register,
              model: user.toJson(),
              networkRequestType: NetworkRequestType.POST_JSON,
              parser: (data) => AuthenticationResult.fromJson(data));
      if (response?.data != null && response.success == true) {
        twoFactorAuthDto = TwoFactorAuthDto(
          userVerificationToken: response.data.token,
          emailOrPhoneNumber: user.phoneNumber,
        );
      }
      return Future.value(response);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<ResponseModel<AuthenticationResult>> generateTwoFactorAuthentication(
      {String code}) async {
    twoFactorAuthDto.code = code;
    try {
      var response =
          await authorizeNetworkService.process<AuthenticationResult>(
        endPoint: ApiRoutes.TwoFactor,
        networkRequestType: NetworkRequestType.POST_JSON,
        model: twoFactorAuthDto.toJson(),
        parser: (data) => AuthenticationResult.fromJson(data),
      );
      if (response?.data != null && response.success == true) {
        await persistToken(
            refreshToken: response.data.refreshToken,
            token: response.data.token);
        app.getRepo().token = response.data.token;
      }
      return Future.value(response);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<ResponseModel<CustomerDto>> getCustomerInfo({
    bool forceNetwork = false,
    Function callBack,
  }) async {
    // if (forceNetwork == false && profileInfo != null) {
    //   return Future.value(profileInfo);
    // }
    var response = await authorizeNetworkService.process<CustomerDto>(
      endPoint: Customer.BaseIdentity,
      networkRequestType: NetworkRequestType.GET_AUTHORIZED_JSON,
      parser: (data) => CustomerDto.fromJson(data),
      age: 1,
      saveLocal: true,
      forceNetwork: forceNetwork,
    );
    if (response?.data != null && response.success) {
      // myInfo = response.data;

      //print(response.data.firstName + "    ===   ");
      profileInfo = response.data;
      myAddresses = response.data.addresses;
    } else {
      ResponseModel.processFailure(response, callBack);
    }
    if (forceNetwork == false) {
      if (response?.data != null && response.success == true) {
        getCustomerInfo(forceNetwork: true);
      } else {
        return getCustomerInfo(forceNetwork: true);
      }
    }
    return response;
  }

  Future<ResponseModel<CustomerDto>> getProfileInfo(
      {Function callBack, bool forceNetwork = false}) {
    // if (profileInfo != null && forceNetwork == false) return profileInfo;
    ////print("getProfileInfo({Function callBack, bool forceNetwork = false})");
    return getCustomerInfo(callBack: callBack, forceNetwork: forceNetwork);
    //return profileInfo;
  }

  Future<ResponseModel<CustomerDto>> updateCustomerInfo(
      {Function callBack, CustomerDto info}) async {
    if (info == null) return null;
    if (info?.imageUrl != null && info.imageUrl.contains(ApiRoutes.CdnPath)) {
      info.imageUrl = info.imageUrl.replaceAll(ApiRoutes.CdnPath, "");
    }
    var model = info.toJson();
    var response = await authorizeNetworkService.process(
      endPoint: Customer.BaseIdentity,
      model: model,
      networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
      parser: (data) => CustomerDto.fromJson(data),
      saveLocal: true,
      forceNetwork: true,
      doNotIncludePost: true,
      age: 1,
    );
    //getCustomerInfo(forceNetwork: true).then((value) => null);
    return ResponseModel.processResponse(response: response);
  }

  Future<List<CustomerAddressDto>> getCustomerAddress(
      {Function callBack, bool forceNetwork}) async {
    if (myAddresses != null && myAddresses.length > 0 && forceNetwork == false)
      return myAddresses;
    await getCustomerInfo(callBack: callBack, forceNetwork: true);
    return myAddresses;
  }

  Future<ResponseModel<List<CustomerAddressDto>>> getCustomerAddresses(
      {Function callBack, bool forceNetwork = false}) async {
    var response =
        await authorizeNetworkService.process<List<CustomerAddressDto>>(
      endPoint: Customer.CreateAddress,
      networkRequestType: NetworkRequestType.GET_AUTHORIZED_JSON,
      parser: (data) => CustomerAddressDto.parseJsonList(data),
      saveLocal: true,
      age: 1,
      forceNetwork: forceNetwork,
    );
    return response;
  }

  Future<ResponseModel<bool>> addCustomerAddress({
    CustomerAddressDto address,
    AddressType addressType,
    Function callBack,
  }) async {
    var addressJson = address.toJson();
    var url = "${Customer.CreateAddress}/${addressType.value}";
    var response = await authorizeNetworkService.process(
        endPoint: url,
        networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
        parser: (data) => int.parse(data) > 0,
        model: addressJson);

    upDateCustomerAddresses(addressType: addressType, id: address.id);
    updateForceCheckout();
    return response;
  }

  upDateCustomerAddresses({AddressType addressType, int id}) {
    DatabaseNetworkTableService.delete(Customer.CreateAddress);
    getCustomerAddress(forceNetwork: true).then((value) => null);
    if (addressType == AddressType.BillingAddress)
      profileInfo.billingAddressId = id;

    if (addressType == AddressType.ShippingAddress)
      profileInfo.shippingAddressId = id;
  }

  Future<ResponseModel<bool>> editCustomerAddress(
      {CustomerAddressDto address,
      AddressType addressType,
      Function callBack}) async {
    var url =
        "${Customer.CreateAddress}/edit/${address.id}/${addressType.value}";
    var addressJson = address.toJson();
    var response = await authorizeNetworkService.process<bool>(
      endPoint: url,
      model: addressJson,
      networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
      parser: (data) {
        return data;
      },
    );
    upDateCustomerAddresses(addressType: addressType, id: address.id);
    updateForceCheckout();
    return response;
  }

  updateForceCheckout() {
    App.get()
        .getRepo()
        .getCartRepository()
        .updateForceCart(removeOldCheckout: true)
        .then((value) => null);
  }

  Future<ResponseModel<CustomerAddressDto>> getBillingOrShippingAddress(
      {AddressType addressType, Function callBack}) async {
    var url = Customer.GetCustomerAddressByAddressType + addressType.value;
    var response = await authorizeNetworkService.process(
      endPoint: url,
      networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
      parser: (data) => CustomerAddressDto.fromJson(data),
    );
    return response;
  }

  Future<bool> hasToken() async {
    var token = await getToken();
    app.appRepo.token = token;
    return Future.value(token != null);
  }

  Future<bool> verifyToken() async {
    var response = await authorizeNetworkService.process(
      endPoint: ApiRoutes.VerifyToken,
      networkRequestType: NetworkRequestType.GET_RAW_AUTHORIZED_JSON,
    );
    return Future.value(response?.success == true);
  }

  Future<ResponseModel<AuthenticationResult>> verifyEmailForForgotPassword(
      {String email}) async {
    if (email != null) {
      var response = await authorizeNetworkService.process(
          endPoint: ApiRoutes.GetEmailVerification + email,
          networkRequestType: NetworkRequestType.GET_JSON,
          parser: (data) => AuthenticationResult.fromJson(data));
      return ResponseModel.processResponse(response: response);
    }
    return null;
  }

  Future<ResponseModel<AuthenticationResult>> verifyCode({String code}) async {
    if (code != null) {
      var response = await authorizeNetworkService.process(
          endPoint: ApiRoutes.GetEmailVerification,
          networkRequestType: NetworkRequestType.POST_JSON,
          model: json.encode(
              {"email": userEmail, "code": code, "token": verificationToken}),
          parser: (data) => AuthenticationResult.fromJson(data));
      return ResponseModel.processResponse(response: response);
    }
    return null;
  }

  Future<ResponseModel<AuthenticationResult>> resetPassword(
      {String password}) async {
    if (password != null) {
      var response = await authorizeNetworkService.process(
          endPoint: ApiRoutes.ResetPassword,
          model: json.encode({
            "email": userEmail,
            "code": password,
            "token": verificationToken
          }),
          networkRequestType: NetworkRequestType.POST_JSON,
          parser: (data) => AuthenticationResult.fromJson(data));

      return ResponseModel.processResponse(response: response);
    }
    return null;
  }

  Future<ResponseModel<AuthenticationResult>> changePassword(
      {String oldPassword, String newPassword}) async {
    if (oldPassword != null && newPassword != null) {
      var model =
          json.encode({"newPassword": newPassword, "oldPassword": oldPassword});
      var response = await authorizeNetworkService.process(
          endPoint: ApiRoutes.ChangePassword,
          model: model,
          networkRequestType: NetworkRequestType.POST_AUTHORIZED_JSON,
          parser: (data) => AuthenticationResult.fromJson(data));
      return ResponseModel.processResponse(response: response);
    }
    return null;
  }

  Future<bool> refreshToken() async {
    var token = app.appRepo.getToken();
    var refreshToken =
        await app.getRepo().getUserRepository().getRefreshToken();
    try {
      var data = {"token": token, "refreshToken": refreshToken};
      var url = ApiRoutes.RefreshToken;
      var response =
          await authorizeNetworkService.process<AuthenticationResult>(
        endPoint: url,
        model: json.encode(data),
        networkRequestType: NetworkRequestType.POST_JSON,
        parser: (data) => AuthenticationResult.fromJson(data),
      );

      if (response.responseStatusCode == 200 && response?.data != null) {
        var parsedData = response?.data;
        if (parsedData?.status == true) {
          token = parsedData.token;
          refreshToken = parsedData.refreshToken;
          await persistToken(token: token, refreshToken: refreshToken);
          app.appRepo.token = token;
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      }
      return Future.value(false);
    } catch (e) {
      ////print(e);
      return Future.value(false);
    }
  }

  // Getter Setter

  Future<String> getToken() async {
    return LocalStorageService.get(AUTH_TOKEN);
  }

  Future<String> getRefreshToken() async {
    return LocalStorageService.get(AUTH_REFRESH_TOKEN);
  }

  Future<void> deleteToken() async {
    await LocalStorageService.delete(AUTH_TOKEN);
    await LocalStorageService.delete(AUTH_REFRESH_TOKEN);
    await LocalStorageService.clear();
    await DatabaseNetworkTableService.clearAuthorized();
    profileInfo = null;
    myAddresses = null;
    customerBillingAddress = null;
    customerShippingAddress = null;
    userEmail = null;
    verificationToken = null;
    print("======All Data deleted======");
    return;
  }

  Future<void> persistToken({String token, String refreshToken}) async {
    ////print("======persist token=====");

    await LocalStorageService.save(AUTH_TOKEN, token);
    await LocalStorageService.save(AUTH_REFRESH_TOKEN, refreshToken);
  }
}
