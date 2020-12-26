import 'dart:io';
import 'package:bluebellapp/models/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkService {
  static BuildContext context;
  static Future<ResponseModel<dynamic>> post(
      {String endPoint, dynamic model, String authToken}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    if (authToken != null) {
      headers.putIfAbsent("Authorization", () => "Bearer " + authToken);
    }
    try {
      final response = await http.post(endPoint, body: model, headers: headers);
      if (response.body != null) {
        return Future.value(ResponseModel(data: response.body));
      } else {
        return Future.value(ResponseModel(data: null, isServerError: true));
      }
    } on SocketException catch (e) {
      if (e.osError.errorCode == 7 ||
          e.osError.errorCode == 111 ||
          e.osError.errorCode == 113) {
        return (Future.value(ResponseModel(data: null, isServerError: true)));
      }
    } catch (e) {
      return Future.value(ResponseModel(data: null, networkError: true));
    }
    return Future.value(ResponseModel(data: null, networkError: true));
  }

  static Future<ResponseModel<dynamic>> get(
      {String endPoint, String authToken}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final url = endPoint;
    if (authToken != null) {
      headers.putIfAbsent("Authorization", () => "Bearer " + authToken);
    }
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        if (response.body != null) {
          return Future.value(ResponseModel(data: response.body));
        }
      } else {
        return (Future.value(ResponseModel(isServerError: true)));
        // If that response was not OK, throw an error.
        //throw CustomException(response.body);
      }
    } on SocketException catch (e) {
      if (e.osError.errorCode == 7 ||
          e.osError.errorCode == 111 ||
          e.osError.errorCode == 113) {
        return (Future.value(ResponseModel(isServerError: true)));
      }
    } catch (e) {
      return (Future.value(ResponseModel(isServerError: true)));
    }
    return Future.value(ResponseModel(data: null, networkError: true));
  }

  static getRaw({String endPoint, String authToken, bool isJson = true}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final url = endPoint;
    if (authToken != null) {
      headers.putIfAbsent("Authorization", () => "Bearer " + authToken);
    }
    final response = await http.get(url, headers: headers);
    return response;
  }

  static Future<ResponseModel<dynamic>> getUpdated(
      {String url, Map<String, String> headers}) async {
    return httpRequestHelper(() {
      return http.get(url, headers: headers);
    });
  }

  static Future<ResponseModel<dynamic>> postUpdated(
      {String url, dynamic model, Map<String, String> headers}) async {
    return httpRequestHelper(() {
      return http.post(url, body: model, headers: headers);
    });
  }

  static Future<ResponseModel<dynamic>> httpRequestHelper(
      Future<Response> request()) async {
    try {
      final response = await request();
      return Future.value(response.getResponseModel());
    } on SocketException catch (e) {
      if (e.osError.errorCode == 7 ||
          e.osError.errorCode == 111 ||
          e.osError.errorCode == 113) {
        return (Future.value(
          ResponseModel(networkError: true),
        ));
      }
    } catch (e) {
      return (Future.value(ResponseModel(isServerError: true)));
    }
    return (Future.value(
      ResponseModel(networkError: true),
    ));
  }
}
