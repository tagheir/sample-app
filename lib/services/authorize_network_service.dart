import 'package:bluebellapp/repos/app_repo.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/network_request_type.dart';
import 'package:bluebellapp/services/database/database_network_table_service.dart';
import 'package:bluebellapp/services/network_service.dart';
import 'package:bluebellapp/models/database/request.dart';
import 'package:bluebellapp/models/response_model.dart';
import 'package:flutter/material.dart';

class AuthorizeNetworkService {
  final AppRepo appRepo;

  AuthorizeNetworkService(this.appRepo);

  Future<ResponseModel<T>> process<T>({
    @required String endPoint,
    @required NetworkRequestType networkRequestType,
    dynamic model,
    bool tryRefreshToken = true,
    bool log = false,
    bool saveLocal = false,
    bool forceNetwork = false,
    bool doNotIncludePost = false,
    int age = 0,
    T Function(dynamic) parser,
    String Function(T) toJson,
  }) async {
    var endPointDb = endPoint;
    if (networkRequestType.isPost() && doNotIncludePost != true) {
      endPointDb = endPointDb + "=> POST = " + model.toString();
    }
    print(
        "$endPointDb, => saveLocal => $saveLocal, forceNetwork => $forceNetwork");
    if (saveLocal == true && forceNetwork == false) {
      var request = await DatabaseNetworkTableService.get(
          endPointDb, networkRequestType.isAuthorized() ? 1 : 0);
      if (request != null) {
        //print(request.toString());
        if (request.age >= age) {
          //print(request.response);
          //var decoded = json.decode(request.response);
          //////print(decoded);
          T model = parser(request.response);
          var responseModel = ResponseModel<T>(success: true, data: model);
          return Future.value(responseModel);
        }
      }
    }
    var headers = getHeaders(networkRequestType);

    ResponseModel<dynamic> response;
    if (networkRequestType == null) return null;
    if (networkRequestType.isGet() || networkRequestType.isGetRaw()) {
      response =
          await NetworkService.getUpdated(url: endPoint, headers: headers);
    } else if (networkRequestType.isJson() || networkRequestType.isPostRaw()) {
      response = await NetworkService.postUpdated(
          url: endPoint, headers: headers, model: model);
    }
    if (response == null) return null;
    ////print(response.data);
    T parsedData;
    if (networkRequestType.isGet() || networkRequestType.isPost()) {
      try {
        if (response.data.toString() == 'true' ||
            response.data.toString() == 'false') {
          parsedData = response.data.toString().parseBool() as T;
        } else
          parsedData = parser(response.data);
      } catch (ex) {
        ////print(ex);
        parsedData = null;
      }
    }

    var parsedResponse =
        ResponseModel.copyBase<dynamic, T>(response, parsedData);
    if ((response.isAuthorizationTokenError || response.isAuthorizationError) &&
        tryRefreshToken == true) {
      var refreshTokenStatus = await appRepo.getUserRepository().refreshToken();
      if (refreshTokenStatus != true) {
        if (saveLocal == true) {
          await saveAndReturn(response, endPointDb, age,
              networkRequestType.isAuthorized() ? 1 : 0);
        }
        return parsedResponse;
      }
      parsedResponse = await process(
        endPoint: endPoint,
        networkRequestType: networkRequestType,
        model: model,
        tryRefreshToken: false,
      );
      return parsedResponse;
    } else {
      if (saveLocal == true) {
        await saveAndReturn(response, endPointDb, age,
            networkRequestType.isAuthorized() ? 1 : 0);
      }
      return parsedResponse;
    }
  }

  Future<void> saveAndReturn(ResponseModel<dynamic> model, String endpoint,
      int age, int authorize) async {
    if (model != null && model.success && model.data != null) {
      var jsonData = (model.data);
      var request = RequestDto(
        name: endpoint,
        response: jsonData,
        age: age,
        authorize: authorize,
      );
      await DatabaseNetworkTableService.insert(request).then((value) {
        //print("Saved ==============> $endpoint");
      });
    }
  }

  Future<bool> refreshToken() async {
    return appRepo.getUserRepository().refreshToken();
  }

  Map<String, String> getHeaders(NetworkRequestType networkRequestType) {
    Map<String, String> headers = {};
    if (networkRequestType == null) return headers;

    if (networkRequestType.isJson()) {
      headers.putIfAbsent('Content-Type', () => 'application/json');
      headers.putIfAbsent('Accept', () => 'application/json');
    }
    if (networkRequestType.isAuthorized()) {
      var token = appRepo.getToken();
      //////print(token.toString());
      headers.putIfAbsent("Authorization", () => "Bearer " + token);
    }
    return headers;
  }
}
