import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/models/contact_us_dto.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/product_detail/product_detail_modal_popup.dart';
import 'package:bluebellapp/screens/product_detail/product_bottom_tab_bar.dart';
import 'package:bluebellapp/screens/product_detail/product_inquiry_tab.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/shared/move_back_button.dart';
import 'package:bluebellapp/screens/shared/status_dialog.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/full_screen_image.dart';
import 'package:bluebellapp/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailMainView extends StatefulWidget {
  final ProductDetailDto productDetail;
  //final ProductDto product;
  final bool isCartProduct;
  final int cartItemId;

  const ProductDetailMainView(
      {Key key,
      this.productDetail,
      //  this.product,
      this.isCartProduct,
      this.cartItemId})
      : super(key: key);
  @override
  _ProductDetailMainViewState createState() => _ProductDetailMainViewState();
}

class _ProductDetailMainViewState extends State<ProductDetailMainView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _scaffoldKeyChild = GlobalKey();
  GetQuoteRequestScreenData getQuoteRequestScreenData;
  AppScreenBloc appScreenBloc;
  ProductDto product;
  Size size;
  Widget cartIcon;

  submitProductInquiry(ContactUsDto contactUsDto) {
    getQuoteRequestScreenData.contactUsDto = contactUsDto;
    var submitQuote = getQuoteRequestScreenData.submitQuote;
    appScreenBloc.onRequestResponseFunction = (data) {
      if (data != null) {
        StatusDialog(
                status: data,
                message: "Product Inquiry Submitted Successfully",
                cntxt: context)
            .show();
      }
    };
    appScreenBloc.add(AppScreenRequestEvent(function: submitQuote));
  }

  @override
  Widget build(BuildContext context) {
    size = AppTheme.size(context);
    appScreenBloc = context.getAppScreenBloc();
    double topHeight = context.paddingTop() * 0.4;
    cartIcon = Container(
      margin: EdgeInsets.only(right: 10, top: topHeight),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: LayoutConstants.borderRadius,
        color: AppTheme.lightTheme.primaryColor,
      ),
      child: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
    );
    getQuoteRequestScreenData = GetQuoteRequestScreenData(context.getAppBloc());
    widget.productDetail.productSpecs
        .sort((a, b) => a.option.length.compareTo(b.option.length));
    var body = Scaffold(
      key: scaffoldKey,
      appBar: _getAppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white.withOpacity(0.98),
      body: Stack(
        key: _scaffoldKeyChild,
        children: <Widget>[
          SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //_appBar(),
                  _getProductImageWidget(),
                  _getProductValuesWidget().padding(AppTheme.padding),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade300,
                  ).padding(AppTheme.h2Padding),
                  _getProductDescriptionWidget().padding(AppTheme.hPadding),
                  widget.productDetail.productSpecs.length > 0
                      ? _getProductSpecificationWidget()
                      : Text(''),
                  LayoutConstants.sizedBox100H
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter, child: getBottomTabBarWidget())
        ],
      ),
    );
    return LayoutScreen(
      childView: body,
      isAppScreenBloc: true,
      showNavigationBar: false,
      showFloatingButton: (widget.productDetail?.price ?? 0) > 0,
    );
  }

  AppBar _getAppBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: MoveBackButton(
          scaffoldKey: scaffoldKey,
          color: AppTheme.lightTheme.primaryColor,
        ),
        actions:
            LayoutConstants.getAppBarActions(context, iconColorPrimary: true));
  }

  Widget getImageWidget(bool isFullScreen) {
    return Center(
      child: Hero(
        tag: "product-image",
        child: Container(
          //margin: EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          height: AppTheme.deviceWidth,
          child: ClipRRect(
            borderRadius: isFullScreen
                ? LayoutConstants.borderRadius
                : BorderRadius.vertical(bottom: LayoutConstants.borderRadius8),
            child: ContainerCacheImage(
              altImageUrl: "https://placehold.it/330",
              fit: BoxFit.fill,
              imageUrl: widget?.productDetail?.pictureWithCdn,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getProductImageWidget() {
    return FullScreenWidget(
      backgroundColor: LightColor.white,
      child: getImageWidget(false),
      fullScreenChild: getImageWidget(true),
    ).padding(EdgeInsets.only(bottom: 10));
  }

  Widget _getProductValuesWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            widget.productDetail?.name ?? '',
            style: TextConstants.H6.apply(color: LightColor.darkGrey),
          ),
        ),
        Expanded(
          flex: widget.productDetail?.price == null ||
                  widget.productDetail.price <= 0
              ? 0
              : 2,
          child: Text(
            widget.productDetail?.price == null ||
                    widget.productDetail.price <= 0
                ? ""
                : GeneralStrings.Currency +
                    widget.productDetail.price.toInt().toString(),
            textAlign: TextAlign.right,
            style: TextConstants.H5.apply(color: LightColor.orange),
          ),
        ),
      ],
    );
  }

  Widget _getProductDescriptionWidget() {
    var description = widget?.productDetail?.fullDescription ?? " ";
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Html(data: description),
          ],
        ),
      ),
    );
  }

  _getProductSpecificationWidget() {
    var specsRows = widget.productDetail.productSpecs
        .map((e) => Expanded(
              flex: 1,
              child: Text.rich(TextSpan(
                  text: "${e.key}:  ",
                  style: TextConstants.H7.apply(color: LightColor.lightBlack),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "${e.option}    ",
                      style: TextConstants.H7.apply(color: LightColor.black),
                    )
                  ])),
            ))
        .toList();
    var specRows =
        getGridRowsList(2, specsRows, size.width - 32, addDummyCard: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Specifications",
            style: TextConstants.H6.apply(color: LightColor.darkGrey)),
        LayoutConstants.sizedBox5H,
        Column(
          children: specRows,
        )
        // Wrap(
        //   children: specsRows,
        // )
      ],
    ).padding(AppTheme.h2Padding);
  }

  Container getBottomTabBarWidget() {
    ////print(widget.product.price.toString());
    return Container(
      height: size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      // height: 150,
      // width: MediaQuery.of(context).size.width,
      child: widget.productDetail.price == 0
          ? ProductInquiryTab(
              onFormClick: () {
                App.get().currentContext.addEvent(ContactUsFormScreenEvent());
                // showDialog(
                //     context: scaffoldKey.currentContext,
                //     builder: (BuildContext context) {
                //       return ProductInquiryForm(
                //         onInquireFormSubmit: (data) {
                //           submitProductInquiry(data);
                //         },
                //       );
                //     });
              },
            )
          : ProductBottomTabBar(
              isCartProduct: widget.isCartProduct,
              templateType: widget.productDetail?.templateType,
              onAddToCartButtonPressed: () {
                showBottomSheet(
                  context: _scaffoldKeyChild.currentContext,
                  builder: (context) => ProductDetailModalPopup(
                    isCartProduct: widget.isCartProduct,
                    cartItemId: widget.cartItemId,
                    scaffoldKey: scaffoldKey,
                  ),
                );
              },
              price: widget?.productDetail?.price,
            ),
    );
  }
}
