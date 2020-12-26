import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/repos/cart_repo.dart';
import 'package:bluebellapp/repos/services_repo.dart';
import 'package:bluebellapp/repos/user_repositry.dart';
import 'package:bluebellapp/services/authorize_network_service.dart';

class AppRepo {
  final App app;
  AuthorizeNetworkService authorizeNetworkService;
  AppRepo(this.app) {
    authorizeNetworkService = AuthorizeNetworkService(this);
  }

  UserRepository userRepository;
  ServiceRepository serviceRepository;
  CartRepository cartRepository;
  String token;

  String getToken() => token;

  AuthorizeNetworkService getNetworkService() {
    if (authorizeNetworkService == null) {
      authorizeNetworkService = AuthorizeNetworkService(this);
    }
    return this.authorizeNetworkService;
  }

  UserRepository getUserRepository() {
    if (userRepository == null) {
      return userRepository = UserRepository(app: app);
    }
    return this.userRepository;
  }

  CartRepository getCartRepository() {
    if (cartRepository == null) {
      return cartRepository = CartRepository(app: app);
    } else {
      return this.cartRepository;
    }
  }

  ServiceRepository getServiceRepository() {
    if (serviceRepository == null) {
      return serviceRepository = ServiceRepository(app: app);
    } else {
      return this.serviceRepository;
    }
  }
}
