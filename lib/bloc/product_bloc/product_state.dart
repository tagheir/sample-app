import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  ProductState();

  @override
  List<Object> get props => [];
}

class ProductStateUninitialized extends ProductState {}

class ProductStateInitialized extends ProductState {
  final ProductDetailDto productDetail;
  final ProductDto product;

  ProductStateInitialized({this.productDetail, this.product});
}

class ProductStateLoading extends ProductState {}
