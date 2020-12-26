import 'package:bluebellapp/models/category_compact_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/landscape/service_image_card.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/widgets.dart';

class LandscapeAllServicesScreen extends StatefulWidget {
  @override
  _LandscapeAllServicesScreenState createState() =>
      _LandscapeAllServicesScreenState();
}

class _LandscapeAllServicesScreenState
    extends State<LandscapeAllServicesScreen> {
  double availableWidth;
  double cardWidth;
  var servicesList;
  CategoryCompactDto categoryDto;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget getServiceDetailWidget(CategoryCompactDto categoryDto) {
    var imageCards = categoryDto.products
        .asMap()
        .entries
        .map((e) => ServiceImageCard(
              title: e?.value?.name,
              imagePath: e.value.pictures.first,
              heightHalfOfWidth:
                  e.key == categoryDto.products.length - 1 && e.key.isEven
                      ? true
                      : false,
              width: e.key == categoryDto.products.length - 1 && e.key.isEven
                  ? availableWidth
                  : cardWidth,
            ))
        .toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(categoryDto?.title,
            style: TextConstants.H5.apply(color: LightColor.landGreen)),
        LayoutConstants.sizedBox5H,
        Html(
          data: categoryDto.description,
        ),
        Column(
          children:
              getGridRowsList(2, imageCards, cardWidth, addDummyCard: false),
        ),
        LayoutConstants.sizedBox30H,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var body;
    categoryDto = context.getAppScreenBloc().data;
    var width = MediaQuery.of(context).size.width;
    availableWidth = width - 40;
    cardWidth = width / 2 - 24;
    servicesList = categoryDto.subCategories
        .map((e) => getServiceDetailWidget(e))
        .toList();
    body = ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
        children: [
          ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: servicesList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return servicesList[index];
              })
        ]);

    return LayoutScreen(
      childView: body,
      scaffoldKey: scaffoldKey,
      screenTitle: GeneralStrings.LANDSCAPE_SERVICES,
      showAppbar: true,
      showNavigationBar: false,
      showQuoteButton: true,
      showHeaderCartButton: true,
    );
  }
}
