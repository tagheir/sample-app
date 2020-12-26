import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/addToCart_dto.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/repos/cart_repo.dart';
import 'package:bluebellapp/resources/constants/helper_constants/attribute_control_type.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/template_type.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/product_detail/product_bottom_tab_bar.dart';
import 'package:bluebellapp/screens/widgets/bottom_sheet_icon_button.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/button_widgets/btn_cancel.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custome_alert_dialog.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/strip_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailModalPopup extends StatefulWidget {
  final bool isCartProduct;
  final int cartItemId;
  GlobalKey<ScaffoldState> scaffoldKey;
  ProductDetailModalPopup(
      {this.isCartProduct, this.cartItemId, this.scaffoldKey}) {
    //////print(isCartProduct);
  }
  @override
  _ProductDetailModalPopupState createState() =>
      _ProductDetailModalPopupState();
}

class _ProductDetailModalPopupState extends State<ProductDetailModalPopup> {
  String currentItemSelected;
  var selectedDate = "";
  DateTime dateTime;
  BuildContext _context;
  ProductDetailDto productDetail;
  ProductDto product;
  CartRepository cartRepo;
  bool isDataLoaded = false;
  bool haveDropDownAttributes = false;
  bool haveDateAttribute = false;
  ProductAttribute productAttr;
  ProductAttribute dateAttr;
  bool canAddToCart = false;
  bool productDataSet = false;
  AddToCartDto myCart = AddToCartDto();
  AttrMap attrMap = AttrMap();
  AttrMap dayMap = AttrMap();
  AttrMap monthMap = AttrMap();
  AttrMap yearMap = AttrMap();
  GlobalKey<ScaffoldState> scaffoldKey;
  CustomProgressDialog pr;
  DateTime currentDate;
  AnimationController controller;
  App appBloc;
  AppScreenBloc appScreenBloc;
  ProductDetailScreenData productDetailScreenData;
  List<AttributeValue> attrVal;
  int quantity = 1;
  double basePrice;
  double price;
  Size size;
  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  @override
  void initState() {
    super.initState();
    scaffoldKey = widget.scaffoldKey ?? GlobalKey<ScaffoldState>();
  }

  var selectedAttributeValues = Map<String, String>();

  @override
  void dispose() {
    super.dispose();
  }

  buyNow() {
    var productAttribute = myCart.directOrderProductAttribute;
    productAttribute.price = productDetail?.price?.toDouble();
    productAttribute.dropDownAttributeValue = currentItemSelected;
    productAttribute.pictureThumb = productDetail?.pictureWithCdn;
    productAttribute.name = productDetail.name;
    productAttribute.dateAttributeValue = selectedDate;
    productAttribute.quantity = quantity;
    Navigator.pop(context);
    context.addEvent(
      DirectCheckoutViewEvent(addToCartDto: myCart),
    );
  }

  addProductToCart(BuildContext context, {bool directCheckout = false}) async {
    if (haveDropDownAttributes) {
      myCart.form.add(attrMap);
    }
    if (haveDateAttribute) {
      if (dayMap.value != null &&
          monthMap.value != null &&
          yearMap.value != null) {
        myCart.form.add(dayMap);
        myCart.form.add(monthMap);
        myCart.form.add(yearMap);
        canAddToCart = true;
      } else {
        CustomAlertDialog.showNew(
            cntxt: context, text: 'Warning !' + '\nService Date Not Selected');
      }
    } else {
      canAddToCart = true;
    }

    if ((widget.isCartProduct != true &&
        canAddToCart == true &&
        productDetail.templateType.isMaintenancePackage() == false)) {
      myCart.quantity = quantity;
      productDetailScreenData.addToCartDto = myCart;
      appScreenBloc.onRequestResponseFunction = (data) {
        //print("Here ON appScreenBloc.onRequestResponseFunction  ==== >");
        if (data != null) {
          //print("Here ON appScreenBloc.onRequestResponseFunction INNER ==== >");
          if (!directCheckout) {
            CustomAlertDialog.showNew(
              cntxt: App.get().currentContext,
              text: '${productDetail.name} has been added to your cart.',
            );
          }
          if (directCheckout) {
            appBloc.add(CartItemsViewEvent());
          }
        }
      };
      //print("h2");

      Navigator.pop(context);
      appScreenBloc.add(
        AppScreenRequestEvent(
          function: productDetailScreenData.addProductToCart,
        ),
      );
    } else if ((canAddToCart == true &&
        productDetail.templateType.isMaintenancePackage() == true)) {
      //buyNow();
    } else if (widget.isCartProduct == true && canAddToCart == true) {
      productDetailScreenData.addToCartDto = myCart;
      appScreenBloc.onRequestResponseFunction = (data) {
        if (data != null) {
          Navigator.pop(context);
          appBloc.add(CartItemsViewEvent());
        }
      };
      appScreenBloc.add(
        AppScreenRequestEvent(
          function: productDetailScreenData.updateCartProduct,
        ),
      );
    }
  }

  getDropDownData(ProductAttribute dropDown) async {
    productAttr = dropDown;
    if (widget.isCartProduct == true) {
      var dropAttr =
          await cartRepo.getDropDownAttributeValue(productId: productDetail.id);
      currentItemSelected = dropAttr?.name;
    } else {
      currentItemSelected = productAttr?.attributeValues?.first?.name;
    }
    attrVal = productAttr?.attributeValues;
    attrMap.key = 'product_attribute_' + productAttr.id.toString();
    setPrice();
    setState(
      () {
        haveDropDownAttributes = true;
      },
    );
  }

  getDateData(ProductAttribute date) async {
    if (widget.isCartProduct == true) {
      selectedDate =
          await cartRepo.getDateAttributeValue(productId: productDetail.id);
    } else {
      selectedDate = DateTime.now().toString();
      setDate(DateTime.now());
    }
    dateAttr = date;
    dayMap.key = 'product_attribute_' + dateAttr.id.toString() + '_day';
    monthMap.key = 'product_attribute_' + dateAttr.id.toString() + '_month';
    yearMap.key = 'product_attribute_' + dateAttr.id.toString() + '_year';
    setState(() {
      haveDateAttribute = true;
    });
  }

  setDate(DateTime date) {
    String formattedDate = DateFormat.yMMMd().format(date);
    selectedDate = formattedDate.toString();
    dayMap.value = date.day.toString();
    monthMap.value = date.month.toString();
    yearMap.value = date.year.toString();
  }

  Widget dropDownWidget(ProductAttribute item) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50,
            child: DropdownButton<String>(
              isExpanded: true,
              items: item.attributeValues.map((attribute) {
                return DropdownMenuItem<String>(
                    value: attribute.name, child: Text(attribute.name));
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  currentItemSelected = newValueSelected;
                });
                setPrice();
                //Your code to execute when menu item is selected by the user
              },
              value: currentItemSelected,
            ),
          ),
        )
      ],
    ).padding(EdgeInsets.only(bottom: 16));
  }

  Widget datePickerWidget(ProductAttribute item) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 2),
      child: Row(
        children: <Widget>[
          Expanded(
            child: StripedCalendarWidget(
              onDateSelected: (userSelectedDate) {
                setDate(userSelectedDate);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getProductQuantityWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Quantity',
            style: TextConstants.H5.apply(color: LightColor.lightBlack),
          ),
          LayoutConstants.sizedBox30H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BottomSheetIconButton(
                onPressed: () {
                  onDecrement();
                },
                width: 35,
                height: 35,
                icon: Icons.remove,
              ),
              Text(
                quantity.toString(),
                style: TextConstants.H3.apply(color: LightColor.lightBlack),
              ),
              BottomSheetIconButton(
                onPressed: () {
                  onIncrement();
                },
                width: 35,
                height: 35,
                icon: Icons.add,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getProductAttributesWidgetList(List<ProductAttribute> attributes) {
    if (attributes == null || attributes.length < 1) return Text('');
    var widgets = List<Widget>();
    for (var item in attributes) {
      var curWidget;
      ////print(item.productAttributeId);
      if (item.productAttributeId == AttributeControlType.DatePicker) {
        curWidget = (datePickerWidget(item));
      } else if (item.productAttributeId == AttributeControlType.DropdownList) {
        curWidget = (dropDownWidget(item));
      }
      if (curWidget != null) {
        widgets.add(Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.textPrompt ?? '',
              style: TextConstants.H6_5.apply(color: LightColor.lightBlack),
            ),
            curWidget,
          ],
        ));
      }
    }
    return Column(children: widgets);
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 16.0, top: size.height * 0.02),
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.orange,
              size: 32,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  setPrice() {
    attrMap.value = attrVal
        .firstWhere((v) => v.name == this.currentItemSelected,
            orElse: () => null)
        .id
        .toString();
    setState(() {
      productDetail.price = basePrice +
          int.parse(attrVal
              .firstWhere((v) => v.name == this.currentItemSelected,
                  orElse: () => null)
              .priceAdjustment
              .toString());
      price = productDetail.price;
    });
  }

  setProductData() {
    if (productDetail?.productAttributes != null) {
      productDetail?.productAttributes?.forEach((a) async {
        switch (a.productAttributeId) {
          case AttributeControlType.DropdownList:
            return await getDropDownData(a);
          case AttributeControlType.DatePicker:
            return await getDateData(a);
        }
      });
    }
    productDataSet = true;
  }

  onIncrement() {
    setState(() {
      quantity += 1;
      price = basePrice * quantity;
    });
  }

  onDecrement() {
    setState(() {
      if (quantity > 1) {
        setState(() {
          quantity -= 1;
          price = price - basePrice;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    appBloc = context.getAppBloc();
    appScreenBloc = context.getAppScreenBloc();
    size = AppTheme.size(context);
    productDetail = appScreenBloc.data;
    myCart.productId = productDetail.id;
    productDetailScreenData = ProductDetailScreenData(appBloc);
    if (price == null && basePrice == null) {
      price = productDetail.price;
      basePrice = productDetail.price;
    }

    if (widget.cartItemId != null) {
      myCart.cartItemId = widget.cartItemId;
    }

    if (productDataSet == false) {
      setProductData();
    }
    return showProductAttributesModalPopup(context);
  }

  showProductAttributesModalPopup(BuildContext context) {
    return Scaffold(
      // appBar: _getAppBar(),
      backgroundColor: LightColor.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CancelButton(
                    context: context,
                  ),
                  getBasicDetails(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  //getProductQuantityWidget(),
                  getProductAttributesWidgetList(
                          productDetail.productAttributes)
                      .padding(EdgeInsets.all(20)),
                  productDetail.templateName ==
                          TemplateTypeHelper.FacilitiesManagementProduct
                      ? getProductQuantityWidget()
                      : Text(''),
                  // productDetail.templateType.isProduct()
                  //     ? getProductQuantityWidget()
                  //     : getProductAttributesWidgetList(
                  //             productDetail.productAttributes)
                  //         .padding(EdgeInsets.all(20)),
                  LayoutConstants.sizedBox100H
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: getBottomTabBarWidget(context),
          )
        ],
      ),
    );
  }

  Container getBottomTabBarWidget(BuildContext context) {
    return Container(
      height: size.height * 0.09,
      width: MediaQuery.of(context).size.width,
      child: ProductBottomTabBar(
        isCartProduct: widget.isCartProduct,
        templateType: productDetail?.templateType,
        onAddToCartButtonPressed: () {
          addProductToCart(context);
        },
        onBuyNowBtnPressed: () =>
            addProductToCart(context, directCheckout: true),
        price: price,
      ),
    );
  }

  Padding getBasicDetails() {
    ////print(productDetail.pictureWithCdn);
    return Padding(
      padding: const EdgeInsets.only(top: 20)
          .add(EdgeInsets.symmetric(horizontal: 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: LayoutConstants.borderRadius,
              child: ContainerCacheImage(
                height: 80,
                altImageUrl: "https://placehold.it/330",
                imageUrl: productDetail.pictureWithCdn,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productDetail.name,
                    style: TextConstants.H6.apply(color: LightColor.lightBlack),
                  ).wrap(),
                  Text(
                    GeneralStrings.Currency + price.toInt().toString(),
                    style: TextConstants.H6.apply(color: LightColor.orange),
                  ).wrap(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
