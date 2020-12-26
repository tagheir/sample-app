import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/category_filter_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/category_circular_card.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/product_compact_view.dart';
import 'package:flutter/rendering.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'filter_modal_popup.dart';

class CategoryScreen extends StatefulWidget {
  String guid;
  final bool isService;
  final Key key;
  bool isSearch;
  CategoryScreen(
      {@required this.key, this.guid, this.isSearch, this.isService});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> childScaffoldKey = GlobalKey<ScaffoldState>();
  Size size;
  CategoryFilterDto category;
  CategoryScreenData screenData;
  AppScreenBloc appScreenBloc;
  App appBloc;
  int rowCount;
  CategoryFilterDto upDatedCategory;
  bool oneTimeInitialized = false;
  ScrollController screenController = ScrollController();
  ScrollController pageController = ScrollController();
  bool disableScroll;
  double offset;
  bool isLoading = false;
  bool isDataLoaded = false;
  int pageNo = 2;
  String noProductsFoundText = "No Products";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(CategoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  oneTimeInitialization() {
    if (oneTimeInitialized == false) {
      size = AppTheme.size(context);
      appBloc = context.getAppBloc();
      appScreenBloc = context.getAppScreenBloc();
      screenData = CategoryScreenData(appBloc);
      screenData.guid = widget.guid;
      oneTimeInitialized = true;
    }
  }

  onSearchSubmit(String str) {
    appScreenBloc.onRequestResponseFunction = (data) {
      setState(() {
        upDatedCategory = data;
        widget.isSearch = false;
        if (upDatedCategory.data.length == 0) {
          setState(() {
            noProductsFoundText = "No products found";
          });
        }
      });
    };
    screenData.searchQuery = str;
    screenData.filteredOptions = "";
    screenData.guid = widget.guid;
    screenData.pageNo = 1;
    appScreenBloc.add(
      AppScreenRequestEvent(
        function: screenData.getScreenData,
      ),
    );
  }

  getFilteredSearchResults(String str) {
    appScreenBloc.onRequestResponseFunction = (data) {
      setState(() {
        upDatedCategory = data;
      });
    };
    screenData.filteredOptions = str;
    screenData.pageNo = 1;
    screenData.guid = widget.guid;
    appScreenBloc.add(
      AppScreenRequestEvent(function: screenData.getScreenData),
    );
  }

  getProducts(index) async {
    if (index == 0) {
      return Future.value(category.data);
    }
    if (index >= 1) {
      screenData.guid = widget.guid;
      screenData.pageNo = index;
      appScreenBloc.onRequestResponseFunction = (data) {
        if (data.data.length > 0) {
          setState(() {
            isLoading = false;
            category.data = category.data + data.data;
            pageNo++;
          });
        } else {
          setState(() {
            isDataLoaded = true;
          });
        }
        // upDatedCategory = data;
        widget.isSearch = true;
      };
      appScreenBloc.add(
        AppScreenRequestEvent(function: screenData.getScreenData),
      );
    }
    //disableScroll = false;
    //screenController.jumpTo(offset);
    //  return Future.value(upDatedCategory.data);
  }

  getSubcategoriesList() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      width: double.infinity,
      height: size.width * 0.38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: category.subCategories
            .map((cat) => Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: CategoryCircleCard(
                    categoryInfoDto: cat,
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    onTap: () {
                      scaffoldKey.currentContext.addEvent(CategoryScreenEvent(
                          guid: cat.seName, isSearch: false));
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  getProductGridList() {
    var width = ((AppTheme.deviceWidth - 16) / rowCount) - 16;
    var isService = widget.isService == true;
    return Container(
      padding:
          EdgeInsets.only(right: 8, left: 8, top: isService ? 8 : 8, bottom: 8),
      child: GridView.builder(
          itemCount: category.data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            //mainAxisSpacing: 16.0,
            // crossAxisSpacing: 16.0,
            childAspectRatio: 0.80,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ProductCompactView(
                  product: category.data[index],
                  width: width,
                  height: width + 60,
                ),
              ),
            );
          }),
    );
  }

  final key = new GlobalKey<_CategoryScreenState>();
  @override
  Widget build(BuildContext context) {
    oneTimeInitialization();
    if (widget.isSearch == false) {
      category = context?.getAppScreenBloc()?.data;
    }
    if (upDatedCategory != null) {
      category = upDatedCategory;
    } else if (category == null) {
      category = CategoryFilterDto();
    }
    appScreenBloc.data = category;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      rowCount = 3;
    } else {
      rowCount = 2;
    }
    List<Widget> body = List<Widget>();
    Widget containerBody;
    if (widget.isService == null || widget.isService == false) {
      if (category.subCategories != null && category.subCategories.length > 0) {
        body.add(
          Text("Departments",
                  textAlign: TextAlign.left,
                  style: TextConstants.H5.apply(color: LightColor.navy))
              .padding(
            EdgeInsets.only(left: 16),
          ),
        );
        body.add(LayoutConstants.sizedBox20H);
        body.add(getSubcategoriesList());
      }
    }

    if (widget.isService != true && !widget.isSearch) {
      body.add(Text(
        'Products',
        textAlign: TextAlign.left,
        style: TextConstants.H5.apply(color: LightColor.navy),
      ).padding(EdgeInsets.only(left: 16)));
    }
    if (category.data != null && category.data.length > 0) {
      if (widget.isService == null || widget.isService == false) {
        body.add(LayoutConstants.sizedBox10H);
      }
      body.add(getProductGridList());
      // if (isLoading == true) {
      //   body.add(LayoutConstants.sizedBox20H);
      //   body.add(LoadingIndicator());
      //   body.add(LayoutConstants.sizedBox50H);
      // }
    } else {
      if (!widget.isSearch) {
        body.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            Text(
              noProductsFoundText,
              style: TextConstants.H6.apply(color: LightColor.navy),
            ),
          ],
        ));
      }
    }

    containerBody = NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              isDataLoaded == false &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              widget.isService == false) {
            setState(() {
              isLoading = true;
            });
            getProducts(pageNo);
            // start loading data
          }
          return null;
        },
        child: ListView(
          shrinkWrap: true,
          children: body,
          // padding: EdgeInsets.all(16),
        ));
    return Scaffold(
      key: scaffoldKey,
      body: LayoutScreen(
        scaffoldKey: childScaffoldKey,
        childView: containerBody,
        showAppbar: true,
        screenTitle: category.name,
        screenTitleColor: LightColor.white,
        addBackButton: true,
        showNavigationBar: false,
        showHeaderCartButton: true,
        isAppScreenBloc: true,
        showSearchBar: widget.isService == true ? false : true,
        showFilterIcon:
            category?.productSpecificationAttributeInfo?.length == null ||
                    category?.productSpecificationAttributeInfo?.length == 0
                ? false
                : true,
        onFilterIconPress: () {
          showBottomSheet(
            context: childScaffoldKey.currentContext,
            builder: (context) => FilterModalPopup(
              onViewSearchPress: (String str) {
                getFilteredSearchResults(str);
              },
              onClearSelection: () {
                getFilteredSearchResults(null);
              },
            ),
          );
        },
        onSearchSubmit: (str) {
          onSearchSubmit(str);
        },
      ),
    );
  }
}
