import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:http/http.dart';

class ResponseModel<T> {
  final int responseStatusCode;
  final bool success;
  final bool networkError;
  final bool isServerError;
  final bool isServerNotResponding;
  final bool isAuthorizationError;
  final bool isAuthorizationTokenError;
  final bool failedResponse;
  String failureError;
  T data;
  ResponseModel(
      {this.success = false,
      this.isAuthorizationError = false,
      this.isServerNotResponding = false,
      this.isAuthorizationTokenError = false,
      this.networkError = false,
      this.data,
      this.isServerError = false,
      this.responseStatusCode = 0,
      this.failedResponse = false});

  static ResponseModel<Output> copyBase<Input, Output>(
      ResponseModel<Input> src, Output data) {
    return ResponseModel<Output>(
      isServerError: src.isServerError,
      networkError: src.networkError,
      isAuthorizationError: src.isAuthorizationError,
      isAuthorizationTokenError: src.isAuthorizationTokenError,
      responseStatusCode: src.responseStatusCode,
      failedResponse: src.failedResponse,
      isServerNotResponding: src.isServerNotResponding,
      success: src.success,
      data: data,
    );
  }

  static bool processFailure(
      ResponseModel response, Function(String) callBack) {
    if (callBack == null) callBack = printCallback;
    if (response == null) {
      callBack(GeneralStrings.SERVER_NOT_RESPONDING);
    } else if (response?.data != null || response.success == true) {
      return false;
    } else if (response.networkError == true) {
      callBack(GeneralStrings.NO_INTERNET_CONNECTION);
    } else if (response.isAuthorizationError ||
        response.isAuthorizationTokenError) {
    } else {
      callBack(GeneralStrings.SERVER_NOT_RESPONDING);
    }
    return true;
  }

  static ResponseModel processResponse(
      {ResponseModel response, Function(String) callBack}) {
    if (callBack == null) callBack = printCallback;
    if (response != null && response.success) {
      return response;
    }
    if (response == null) {
      response.failureError = GeneralStrings.SERVER_NOT_RESPONDING;
      callBack(GeneralStrings.SERVER_NOT_RESPONDING);
    } else if (response.networkError == true) {
      response.failureError = GeneralStrings.NO_INTERNET_CONNECTION;
      callBack(GeneralStrings.NO_INTERNET_CONNECTION);
    } else if (response.isAuthorizationError ||
        response.isAuthorizationTokenError) {
      response.failureError = "Token Authorization Error";
    } else {
      response.failureError = GeneralStrings.SERVER_NOT_RESPONDING;
      callBack(GeneralStrings.SERVER_NOT_RESPONDING);
    }
    return response;
  }

  static void printCallback(String msg) {
    //print(msg);
  }
}

extension ResponseExtension on Response {
  ResponseModel<String> getResponseModel() {
    var response = this;
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return ResponseModel(
        data: response.body,
        responseStatusCode: response.statusCode,
        success: true,
      );
    } else if (response.statusCode == 400) {
      // If server returns an Bad Request response, parse the JSON.
      return ResponseModel(
        data: response.body,
        responseStatusCode: response.statusCode,
        failedResponse: true,
      );
    } else if (response.statusCode == 401) {
      // If server returns an Failed Authorization response, parse the JSON.
      return ResponseModel(
        data: response.body,
        responseStatusCode: response.statusCode,
        isAuthorizationError: true,
      );
    } else if (response.statusCode == 404) {
      // If server returns an Token Expiration response, parse the JSON.
      return ResponseModel(
        data: response.body,
        responseStatusCode: response.statusCode,
        isAuthorizationTokenError: true,
      );
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      // If server returns an Bad Request response, parse the JSON.
      return ResponseModel(
        data: null,
        responseStatusCode: response.statusCode,
        isServerNotResponding: true,
      );
    } else {
      return ResponseModel(
        isServerError: true,
      );
      // If that response was not OK, throw an error.
      //throw CustomException(response.body);
    }
  }
}
