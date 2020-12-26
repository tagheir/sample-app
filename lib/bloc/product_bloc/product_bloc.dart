import 'package:bloc/bloc.dart';
import 'package:bluebellapp/bloc/product_bloc/product_event.dart';
import 'package:bluebellapp/bloc/product_bloc/product_state.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/repos/services_repo.dart';
import 'package:bluebellapp/app.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductDetailDto productDetail;
  ProductDto product;

  String seName;
  int cartItemId;
  bool isCartProduct;

  App appBloc;
  ServiceRepository serviceRepository;

  ProductBloc(ProductState initialState) : super(initialState);

  @override
  get initialState => ProductStateUninitialized();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is ProductDetailEvent) {
      if (event.productDetail != null && event.product != null) {
        productDetail = productDetail;
        product = product;
      }
      yield ProductStateInitialized();
    }
    if (event is ProductParamEvent) {
      yield ProductStateLoading();

      isCartProduct = event.isCartProduct;
      seName = event.seName;
      cartItemId = event.cartItemId;
      appBloc = event.appBloc;
      serviceRepository = appBloc?.appRepo?.getServiceRepository();
      if (serviceRepository != null) {
        var _productDetail =
            await serviceRepository.getProductDetail(seName: seName);
        productDetail = _productDetail.data;
        yield ProductStateInitialized(
          productDetail: productDetail,
        );
      }
    }
  }

  setProductData({ProductDetailDto productDetail, ProductDto product}) {
    if (productDetail != null && product != null) {
      this.productDetail = productDetail;
      this.product = product;
    }
  }

  // @override
  // ProductState get initialState => AppStateUninitialized();
}
