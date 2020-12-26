import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/landscape_service_detail_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/landscape/landscape_project_card.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

class LandscapeServiceDetailScreen extends StatefulWidget {
  final String guid;
  LandscapeServiceDetailScreen({this.guid});
  @override
  _LandscapeServiceDetailScreenState createState() =>
      _LandscapeServiceDetailScreenState();
}

class _LandscapeServiceDetailScreenState
    extends State<LandscapeServiceDetailScreen> {
  double availableWidth;
  LandscapeServiceDetailDto serviceDetailDto;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget getProductImageWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      height: 330,
      decoration: BoxDecoration(
          color: AppTheme.lightTheme.primaryColor,
          borderRadius:
              BorderRadius.vertical(bottom: LayoutConstants.borderRadius8)),
      child: ClipRRect(
          borderRadius:
              BorderRadius.vertical(bottom: LayoutConstants.borderRadius8),
          child: ContainerCacheImage(
            altImageUrl: "https://placehold.it/600",
            imageUrl: serviceDetailDto?.productDetailDto?.pictureWithCdn,
            fit: BoxFit.cover,
          )),
    );
  }

  Widget getImageWidget(bool isFullScreen) {
    return Center(
      child: Hero(
        tag: "service-image",
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
              imageUrl: serviceDetailDto?.productDetailDto?.pictureWithCdn,
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
    );
  }

  getProjects() {
    var projects = serviceDetailDto?.landscapeProjects;
    if (projects != null && projects.length > 0) {
      var projectWidgets = projects
          .map((e) => Container(
                padding: EdgeInsets.only(left: 4, right: 4, bottom: 10),
                child: LandscapeProjectCard(
                  title: e.name,
                  imagePath: e.picturePathWithCdn.first,
                  location: e.address,
                  availableWidth: availableWidth * 0.7,
                  availableHeight: (availableWidth / 1.64),
                  onTap: () {
                    context.addEvent(
                        LandscapeProjectImagesScreenEvent(guid: e.name));
                  },
                ),
              ))
          .toList();
      return Container(
        height: (availableWidth / 1.4),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: projectWidgets,
        ),
      );
    }
  }

  Widget _getProductValuesWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        serviceDetailDto?.productDetailDto?.name ?? '',
        style: TextConstants.H5.apply(color: LightColor.darkGrey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var body;
    availableWidth = MediaQuery.of(context).size.width - 16;
    serviceDetailDto = context.getAppScreenBloc().data;
    body = ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Padding(
            padding: EdgeInsets.only(left: 16, right: 18, top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getProductValuesWidget(),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade300,
                ), //.padding(AppTheme.h2Padding),
                Html(data: serviceDetailDto?.productDetailDto?.fullDescription),
                LayoutConstants.sizedBox10H,
                serviceDetailDto.landscapeProjects.length > 0
                    ? Text(
                        GeneralStrings.RELATED_PROJECTS,
                        style:
                            TextConstants.H6.apply(color: Colors.grey.shade700),
                      )
                    : Text(''),
                LayoutConstants.sizedBox10H,
                getProjects() ?? Text('')
              ],
            )),
      ],
    );
    return LayoutScreen(
      childView: body,
      showAppbar: true,
      scaffoldKey: scaffoldKey,
      showNavigationBar: false,
      showBannerImage: true,
      bannerImagePath: serviceDetailDto?.productDetailDto?.pictureWithCdn,
      showQuoteButton: true,
      screenTitle: serviceDetailDto?.productDetailDto?.name ?? '',
      showHeaderCartButton: true,
      showHeaderProfileIcon: false,
      showHeaderHomeIcon: false,
      showFloatingButton: false,
    );
  }
}
