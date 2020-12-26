import 'dart:convert';

import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/category_dto.dart';
import 'package:bluebellapp/models/category_compact_dto.dart';
import 'package:bluebellapp/models/category_filter_dto.dart';
import 'package:bluebellapp/models/contact_us_dto.dart';
import 'package:bluebellapp/models/dashboard_view_model.dart';
import 'package:bluebellapp/models/homeViewModel.dart';
import 'package:bluebellapp/models/landscapeHomeViewModel.dart';
import 'package:bluebellapp/models/landscape_project_dto.dart';
import 'package:bluebellapp/models/landscape_service_detail_dto.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/models/response_model.dart';
import 'package:bluebellapp/models/storeHomeViewModel.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/network_request_type.dart';
import 'package:bluebellapp/services/authorize_network_service.dart';

class ServiceRepository {
  final App app;
  AuthorizeNetworkService authorizeNetworkService;
  ServiceRepository({this.app}) {
    authorizeNetworkService = app.getRepo().getNetworkService();
  }
  AuthorizeNetworkService getAuthorizeNetworkService() {
    if (authorizeNetworkService == null) {
      authorizeNetworkService = app.getRepo().getNetworkService();
    }
    return authorizeNetworkService;
  }

  ServicesHomeViewModel homePageViewModel;
  StoreHomePageViewModel storeHomePageViewModel;
  LandscapeHomeViewModel landscapeHomeViewModel;
  DashBoardViewModel dashBoardViewModel;
  List<ProductDetailDto> products = List<ProductDetailDto>();

  Future<ResponseModel<DashBoardViewModel>> getDashboardDataResponseModel({
    Function(String) callback,
    bool forceNetwork = false,
  }) async {
    if (dashBoardViewModel != null && forceNetwork == false) {
      return Future.value(
          ResponseModel(data: dashBoardViewModel, success: true));
    }
    var response =
        await getAuthorizeNetworkService().process<DashBoardViewModel>(
      endPoint: Dashboard.DashboardBase,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => DashBoardViewModel.fromJson(data),
      age: 1,
      saveLocal: true,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<ServicesHomeViewModel>> getServicesHomeData({
    Function(String) callback,
    bool forceNetwork = false,
  }) async {
    if (homePageViewModel != null && forceNetwork == false) {
      return Future.value(
          ResponseModel(data: homePageViewModel, success: true));
    }
    var response =
        await getAuthorizeNetworkService().process<ServicesHomeViewModel>(
      endPoint: FacilityManagement.GetFacilityManagementHomePageView,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => ServicesHomeViewModel.fromJson(data),
      age: 2,
      saveLocal: true,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<LandscapeHomeViewModel>>
      getLandscapeHomeViewResponseModel({
    Function(String) callback,
    bool forceNetwork = false,
  }) async {
    var model = LandscapeHomeViewModel.getLandscapeHomeViewModel();
    if (model != null) {
      model.setLandscapeImagesPath();
    }
    return ResponseModel(
      data: model,
      success: true,
    );
    // if (landscapeHomeViewModel != null && forceNetwork == false) {
    //   return Future.value(
    //       ResponseModel(data: landscapeHomeViewModel, success: true));
    // }
    // var response =
    //     await getAuthorizeNetworkService().process<LandscapeHomeViewModel>(
    //   endPoint: Landscape.GetLandscapeHomePageView,
    //   networkRequestType: NetworkRequestType.GET_JSON,
    //   parser: (data) => LandscapeHomeViewModel.fromJson(data),
    //   age: 1,
    //   saveLocal: true,
    // );
    // //  ////print(response.data.toString());
    // return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<StoreHomePageViewModel>> getStoreHomeData({
    Function(String) callback,
    bool forceNetwork = false,
  }) async {
    // if (storeHomePageViewModel != null && forceNetwork == false) {
    //   return Future.value(storeHomePageViewModel);
    // }
    var response =
        await getAuthorizeNetworkService().process<StoreHomePageViewModel>(
      endPoint: Store.GetStoreHomePageView,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => StoreHomePageViewModel.fromJson(data),
      age: 2,
      saveLocal: true,
    );
    ResponseModel.processResponse(response: response);
    return response;
  }

  Future<List<ProductDto>> searchProducts(String query) async {
    if (query.isEmpty) {
      return Future.value(List<ProductDto>());
    }
    var url = Product.Search + "?q=" + query;
    var response = await getAuthorizeNetworkService().process<List<ProductDto>>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => ProductDto.fromJsonList(data),
      age: 1,
      saveLocal: true,
    );
    if (response?.data != null && response.success == true) {
      return response.data;
    }
    ResponseModel.processResponse(response: response);
    return List<ProductDto>();
  }

  // Future<ProductDto> getProductById({int productId, CategoryName catName = CategoryName.FacilityManagement}) {
  //   switch (catName) {
  //     case CategoryName.FacilityManagement:
  //       var product = getProductFromSubCategories(
  //           homePageViewModel?.facilitiesManagementServices?.subCategories,
  //           productId);
  //       return product == null ? getProductById(productId: productId, catName: CategoryName.LandscapeServices): Future.value(product);
  //     case CategoryName.LandscapeServices:
  //       var product = getProductFromSubCategories(
  //           homePageViewModel?.landscapeServices?.subCategories, productId);
  //       return product == null ? getProductById(productId: productId, catName: CategoryName.Packages) :Future.value(product);
  //     case CategoryName.Packages:
  //       var product =
  //           getProductFromProducts(homePageViewModel?.packages, productId);
  //       return product == null ? getProductById(productId: productId, catName: CategoryName.Products) : Future.value(product);
  //     case CategoryName.Products:
  //       var product = getProductFromSubCategories(
  //           homePageViewModel?.products?.subCategories,
  //           productId);
  //       return Future.value(product);
  //   }
  //   return Future.value(ProductDto());
  // }

  Future<ResponseModel<ProductDto>> getProductById(
      {Function(String) callback, int productId}) async {
    var url = Product.BaseIdentity;
    var response = await getAuthorizeNetworkService().process<ProductDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.POST,
      model: [productId],
      parser: (data) => ProductDto.fromJson(data),
      age: 1,
      saveLocal: true,
    );
    ResponseModel.processResponse(response: response);
    return response;
  }

  Future<ResponseModel<ProductDetailDto>> getProductDetail(
      {Function(String) callback, String seName}) async {
    var url = Product.GetProductByGuid.replaceAll("{guid}", seName);
    var response = await getAuthorizeNetworkService().process<ProductDetailDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => ProductDetailDto.fromJson(data),
      age: 1,
      saveLocal: true,
    );
    ResponseModel.processResponse(response: response);
    return response;
  }

  Future<ResponseModel<ProductDetailDto>> getProductDetailResponseModelByGuid(
      {Function(String) callback, String guid}) async {
    var url = Product.BaseIdentity;
    url = url + '/g/' + guid + '?includeParentCategory=false';
    var response = await getAuthorizeNetworkService().process<ProductDetailDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => ProductDetailDto.fromJson(data),
      age: 1,
      saveLocal: true,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<CategoryCompactDto>> getLandscapeServicesResponseModel(
      {Function(String) callback, String guid}) async {
    return ResponseModel(
        data: CategoryCompactDto.getLandscapeAllServicesModel(), success: true);
    // var url = Landscape.GetLandscapeServices;
    // var response =
    //     await getAuthorizeNetworkService().process<CategoryCompactDto>(
    //   endPoint: url,
    //   networkRequestType: NetworkRequestType.GET_JSON,
    //   parser: (data) => CategoryCompactDto.fromJson(data),
    // );
    // return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<LandscapeServiceDetailDto>>
      getLandscapeServiceDetailResponseModel(
          {Function(String) callback, String guid}) async {
    var url = Landscape.GetLandscapeServiceDetail.replaceAll("{guid}", guid);
    ////print(url);
    var response =
        await getAuthorizeNetworkService().process<LandscapeServiceDetailDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => LandscapeServiceDetailDto.fromJson(data),
      age: 1,
      saveLocal: true,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<List<LandscapeProjectDto>>>
      getLandscapeProjectsResponseModel(
          {Function(String) callback, String categoryGuid}) async {
    var url = Project.ProjectBase;
    if (categoryGuid != null) {
      url = url + categoryGuid;
    }
    var response =
        await getAuthorizeNetworkService().process<List<LandscapeProjectDto>>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => LandscapeProjectDto.fromMapList(str: data),
      saveLocal: true,
      age: 1,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<LandscapeProjectDto>>
      getLandscapeProjectsByIdResponseModel(
          {Function(String) callback, String projectId}) async {
    var url = Project.GetProjectById + projectId;
    var response =
        await getAuthorizeNetworkService().process<LandscapeProjectDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => LandscapeProjectDto.fromJson(data),
      age: 1,
      saveLocal: true,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<bool>> getQuoteResponseModel(
      {Function(String) callback, String guid, ContactUsDto contactUs}) async {
    var url = Category.GetQuote;
    var response = await getAuthorizeNetworkService().process<bool>(
      endPoint: url,
      model: contactUs.toJson(),
      networkRequestType: NetworkRequestType.POST_JSON,
      parser: (data) => data,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<CategoryCompactDto>> getCategoryData(
      {Function(String) callback,
      bool forceNetwork = false,
      String guid}) async {
    var url = Category.GetCategory + guid + '?includeProducts=true';
    var response =
        await getAuthorizeNetworkService().process<CategoryCompactDto>(
      endPoint: url,
      networkRequestType: NetworkRequestType.GET_JSON,
      parser: (data) => CategoryCompactDto.fromJson(data),
      age: 1,
      saveLocal: true,
    );
    return ResponseModel.processResponse(response: response);
  }

  Future<ResponseModel<CategoryFilterDto>> getCategoryDataWithProductFilters({
    String categoryName,
    String filteredOptions,
    int pageNum = 1,
    String search,
    bool includeStats = true,
  }) async {
    var url = Category.GetCategoryWithProductFilters + includeStats.toString();
    var model = json.encode({
      "categoryName": categoryName,
      "filteredOptions": filteredOptions,
      "pageNum": pageNum,
      "search": search
    });
    ////print(model.toString());
    var response =
        await getAuthorizeNetworkService().process<CategoryFilterDto>(
      endPoint: url,
      model: model,
      networkRequestType: NetworkRequestType.POST_JSON,
      parser: (data) => CategoryFilterDto.fromJson(data),
      saveLocal: true,
      age: 1,
    );
    return ResponseModel.processResponse(response: response);
  }
}
