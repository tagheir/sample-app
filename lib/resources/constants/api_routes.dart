class ApiRoutes {
  // static const String ApiBase = "https://construction.octacer.net/api";
  static const String Query =
      "https://construction.octacer.net/api/rq_post_user";

  static const String CdnPath =
      "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/"; //"https://nopstorageaccount.blob.core.windows.net/content/";

  //static const String ApiBase =  "http://192.168.100.140/bluebell/api";
  //static const String ApiBase = "https://bluebellapi-v2.octacer.com/api";

  // static const String Base = "https://dev-bluebell-api.octacer.com";
  static const String Base = "https://api.bluebell.pk";
  static const String ApiBase = Base + "/api";

  //Home Page View Data

  // Authentication
  static const String AuthBase = ApiBase + "/identity";
  static const String VerifyToken = ApiBase + "/verifyAuthentication";
  static const String Login = AuthBase + "/login";
  static const String LoginWithP = AuthBase + "/loginphonenumber";
  static const String TwoFactor = AuthBase + "/twofactor";
  static const String Register = AuthBase + "/register";
  static const String RefreshToken = AuthBase + "/refresh";
  static const String Claims = AuthBase + "/claims";
  static const String GetEmailVerification = ApiBase + "/forgotpassword?email=";
  static const String GetCodeVerification = ApiBase + "/forgotpassword";
  static const String ResetPassword = ApiBase + "/resetpassword";
  static const String ChangePassword = ApiBase + "/changepassword";
}

// Project Info

class Category {
  static const String CategoryBase = ApiRoutes.ApiBase + "/category";
  static const String GetCategory = CategoryBase + "/g/";
  static const String GetCategoryWithProductFilters =
      CategoryBase + "/stats/products?includeStats=";
  static const String GetHomePageView = CategoryBase + "/homepageview";
  static const String GetStoreHomePageView = CategoryBase + "/store-home-page";
  static const String GetQuote = CategoryBase + "/getquote";
}

class Dashboard {
  static const String DashboardBase = ApiRoutes.ApiBase + "/dashboard";
}

class Landscape {
  static const String LandscapeBase = ApiRoutes.ApiBase + "/landscape";
  static const String GetLandscapeHomePageView = LandscapeBase + "/home";
  static const String GetLandscapeServices = LandscapeBase + "/services";
  static const String GetLandscapeServiceDetail =
      LandscapeBase + "/products/{guid}";
}

class Project {
  static const String ProjectBase = ApiRoutes.ApiBase + "/projects";
  static const String GetProjectByCategory = ProjectBase + "/";
  static const String GetProjectById = ProjectBase + "/id?id=";
}

class FacilityManagement {
  static const String FacilityManagementBase =
      ApiRoutes.ApiBase + "/facilities-management";
  static const String GetFacilityManagementHomePageView =
      FacilityManagementBase + "/home";
}

class Store {
  static const String StoreBase = ApiRoutes.ApiBase + "/eStore";
  static const String GetStoreHomePageView = StoreBase + "/home";
}

class Product {
  static const String BaseIdentity = ApiRoutes.ApiBase + "/products";
  static const String Search = ApiRoutes.ApiBase + "/search";
  static const String GetProductById = BaseIdentity + "/{id}";
  static const String GetProductByGuid = BaseIdentity + "/g/{guid}";
}

class Customer {
  static const String BaseIdentity = ApiRoutes.ApiBase + "/customer";
  static const String GetAllCustomers = BaseIdentity;
  static const String GetCustomerByIdOrGuid = BaseIdentity + "/{customerId}";
  static const String CreateAddress = BaseIdentity + "/address";
  static const String GetCustomerAddressByAddressType =
      BaseIdentity + "/addresstype/";
}

class Cart {
  static const String CartBase = ApiRoutes.ApiBase + "/cart";
  static const String CartByCustomerId = CartBase;
  static const String AddItemsToCart =
      CartBase + "/{productId}/{shoppingCartTypeId}/{quantity}";
  static const String UpdateCart = CartBase + "/updateCart";
  static const String DeleteCart = CartBase + "/{cartItemId}";
  static const String GetCheckoutModel = ApiRoutes.Base + "/checkout";
}

class Order {
  static const String BaseIdentity = ApiRoutes.ApiBase + "/order";
  static const String GetCustomerOrder = BaseIdentity + "?pageNo=";
  static const String GetOrderById = BaseIdentity + "/{orderId}";
  static const String CreateOrderByShoppingCart = BaseIdentity;
  static const String CreateDirectOrder = ApiRoutes.ApiBase + "/direct-order";
  static const String UpdateOrderPaymentMethod = ApiRoutes.ApiBase +
      "/updatepaymentmethod/orderId?paymentMethod=methodType";
}

class OrderPayment {
  static const String BaseIdentity =
      "https://bluebellapi-v2.octacer.com" + "/order";
  static const String OrderPaymentRedirecton =
      BaseIdentity + "/payment/{orderId}";
}
