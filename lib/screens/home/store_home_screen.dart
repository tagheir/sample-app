import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/page_view_data.dart';
import 'package:bluebellapp/models/storeHomeViewModel.dart';
import 'package:bluebellapp/repos/services_repo.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/responsive_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/category_home_screen.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/category_circular_card.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/product_compact_view.dart';
import 'package:bluebellapp/services/category_service.dart';
import 'package:flutter/material.dart';

class StoreHomeScreen extends StatefulWidget {
  @override
  _StoreHomeScreenState createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen>
    with TickerProviderStateMixin {
  bool dataInitialized = false;
  bool isDataLoaded = false;
  bool isDataLoadedFailure = false;
  bool isDataLoadingInProgress = false;
  static StoreHomePageViewModel storeHomePageViewModel;
  ServiceRepository serviceRepo;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var availableWidth;
  int rowCount = ResponsiveConstants.gridRowCount;
  AnimationController animationController;
  Size size;
  var body = List<Widget>();
  var containerBody;

  @override
  void initState() {
    if (mounted) {
      animationController = AnimationController(
          duration: Duration(milliseconds: 400), vsync: this);
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  Widget getFeaturedCategories() {
    return Container(
      width: double.infinity,
      height: size.width * 0.34,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: storeHomePageViewModel.featuredCategories
            .map((category) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: CategoryCircleCard(
                    categoryInfoDto: category,
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget getFeaturedProducts() {
    var width = (AppTheme.deviceWidth / 2) - 16;
    //print(width);
    var list =
        storeHomePageViewModel.featuredProducts.asMap().entries.map((entry) {
      var prod = entry.value;
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: ProductCompactView(
            product: prod,
            width: width,
            height: width + 64,
          ),
        ),
      );
    }).toList();
    return Column(
      children: getGridRowsList(rowCount, list, availableWidth + 48),
    ).padding(EdgeInsets.only(bottom: 8));
  }

  Widget getPromotedFeaturedProducts() {
    var width = (AppTheme.deviceWidth / 3) - 8;
    return Container(
      width: double.infinity,
      height: availableWidth + 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: storeHomePageViewModel.promotedFeaturedProducts
            .map(
              (product) => Container(
                width: width + 8,
                padding:
                    EdgeInsets.only(left: 4, right: 4, bottom: 20, top: 20),
                child: ProductCompactView(
                  product: product,
                  width: width,
                  height: availableWidth + 70,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // Widget _subTitle(String title, Function onTap) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Text(title, style: TextConstants.H5.apply(color: LightColor.navy)),
  //       Spacer(),
  //       GestureDetector(
  //         onTap: () {
  //           onTap();
  //         },
  //         child: Icon(
  //           Icons.navigate_next,
  //           color: LightColor.navy,
  //           size: 40,
  //         ),
  //       )
  //     ],
  //   );
  // }

  List<SliderViewDto> getSliderDtoList() {
    var banners = storeHomePageViewModel?.banners;
    if (banners.length == 0) {
      return List<SliderViewDto>();
    } else {
      return banners
          .map((e) => SliderViewDto(
              assetsImage: e.bannerUrl,
              titleText: e.title,
              onClick: () {
                context.addEvent(CategoryScreenEvent(
                    guid: e.seName, isSearch: false, isService: false));
              }))
          .toList();
    }
  }

  initialize() {
    if (!dataInitialized) {
      serviceRepo = serviceRepo ?? context.getRepo().getServiceRepository();
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        rowCount = 3;
      } else {
        rowCount = 2;
      }
      size = AppTheme.size(context);
      availableWidth = (size.width) / rowCount - 64;
      storeHomePageViewModel = context.getAppScreenBloc().data;
      dataInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    if (body.length == 0) {
      if (storeHomePageViewModel.featuredCategories.length > 0) {
        body.add(Text('Featured Categories',
            textAlign: TextAlign.left,
            style: TextConstants.H5.apply(color: LightColor.navy)));
        // body.add(_subTitle('Featured Categories', () {
        //   context.addEvent(CategoryScreenEvent());
        // }));
        body.add(LayoutConstants.sizedBox10H);
        body.add(getFeaturedCategories());
        body.add(LayoutConstants.sizedBox20H);
      }
      if (storeHomePageViewModel.promotedFeaturedProducts.length > 0) {
        body.add(
          Text('Promoted Products',
              textAlign: TextAlign.left,
              style: TextConstants.H5.apply(color: LightColor.navy)),
        );
        body.add(getPromotedFeaturedProducts());
      }
      if (storeHomePageViewModel.featuredProducts.length > 0) {
        // body.add(_subTitle('Featured Products', () {
        //   context.addEvent(
        //     CategoryProductsViewEvent(
        //       products: storeHomePageViewModel?.featuredProducts,
        //     ),
        //   );
        // }));
        body.add(
          Text('Featured Products',
              textAlign: TextAlign.left,
              style: TextConstants.H5.apply(color: LightColor.navy)),
        );
        body.add(LayoutConstants.sizedBox10H);
        body.add(getFeaturedProducts());
        body.add(LayoutConstants.sizedBox20H);
      }
    }
    containerBody = Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: body,
        ).padding(EdgeInsets.all(8)),
      ],
    );
    body.add(LayoutConstants.sizedBox20H);
    return CategoryHomeScreen(
      body: containerBody.children,
      scaffoldKey: _scaffoldKey,
      screenTitle: GeneralStrings.E_STORE_TITLE,
      sliderContentList: getSliderDtoList(),
      showSearchBar: false,
      showBackButton: true,
      showSearchButton: true,
    );
  }
}
