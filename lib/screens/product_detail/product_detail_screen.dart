import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/models/addToCart_dto.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/repos/cart_repo.dart';
import 'package:bluebellapp/repos/services_repo.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/product_detail/product_detail_main_view.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String seName;
  final int cartItemId;
  final bool isCartProduct;
  ProductDetailPage({
    this.seName,
    this.isCartProduct = false,
    this.cartItemId,
  });
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  //BuildContext cntxt;
  ProductDetailDto productDetail;
  CartRepository cartRepo;
  ServiceRepository serviceRepo;
  AddToCartDto myCart = AddToCartDto();
  bool isDataLoaded = false;
  AppScreenBloc appScreenBloc;
  //AppBloc appBloc;
  //ProductBloc productBloc;

  @override
  Widget build(BuildContext context) {
    {
      // appBloc = context.getAppBloc();
      // productBloc = context.getProductBloc();
      // cartRepo = appBloc.getRepo().getCartRepository();
      // serviceRepo = appBloc.getRepo().getServiceRepository();
      appScreenBloc = context.getAppScreenBloc();
      productDetail = appScreenBloc.data;
      return ProductDetailMainView(
        productDetail: appScreenBloc.data,
        isCartProduct: widget.isCartProduct,
        cartItemId: widget.cartItemId,
      );
      // return BlocBuilder<ProductBloc, ProductState>(
      //   builder: (context, state) {
      //     ////print(state);
      //     if (state is ProductStateUninitialized) {
      //       context.getProductBloc().add(ProductParamEvent(
      //             appBloc: context.getAppBloc(),
      //             cartItemId: widget.cartItemId,
      //             isCartProduct: widget.isCartProduct,
      //             seName: widget.seName,
      //           ));
      //       return LoadingScreen();
      //     }
      //     if (state is ProductStateLoading) {
      //       return LoadingScreen();
      //     }
      //     if (state is ProductStateInitialized) {
      //       return ProductDetailMainView(
      //         productDetail: state.productDetail,
      //         isCartProduct: widget.isCartProduct,
      //         cartItemId: widget.cartItemId,
      //       );
      //     }
      //     return Text('FAILED !!!').center();
      //   },
      //);
    }
  }
}
