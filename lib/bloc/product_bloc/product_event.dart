import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  ProductEvent();
}

class ProductDetailEvent extends ProductEvent {
  final ProductDetailDto productDetail;
  final ProductDto product;
  ProductDetailEvent({
    this.productDetail,
    this.product,
  });

  @override
  List<Object> get props => [this.productDetail, this.product];
}

class ProductParamEvent extends ProductEvent {
  final String seName;
  final int cartItemId;
  final bool isCartProduct;
  final App appBloc;
  ProductParamEvent({
    this.appBloc,
    this.seName,
    this.cartItemId,
    this.isCartProduct,
  });

  @override
  // TODO: implement props
  List<Object> get props =>
      [this.appBloc, this.seName, this.cartItemId, this.isCartProduct];
}
