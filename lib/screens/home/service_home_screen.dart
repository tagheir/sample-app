import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/homeViewModel.dart';
import 'package:bluebellapp/models/page_view_data.dart';
import 'package:bluebellapp/repos/services_repo.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/responsive_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/facilities_management_services_grid_screen.dart';
import 'package:bluebellapp/screens/shared/category_home_screen.dart';
import 'package:bluebellapp/services/category_service.dart';
import 'package:flutter/material.dart';

class ServicesHomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ServicesHomeScreen>
    with TickerProviderStateMixin {
  ServicesHomeViewModel homePageViewModel;
  ServiceRepository serviceRepo;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController animationController;
  var availableWidth;
  int rowCount = ResponsiveConstants.gridRowCount;

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

  List<SliderViewDto> getSliderContentList() {
    return homePageViewModel.banners
        .map((e) => SliderViewDto(
              titleText: e.title,
              assetsImage: e.bannerUrl,
            ))
        .toList();
  }

  Widget getFacilitiesManagementServicesSlider() {
    var list = homePageViewModel.services.asMap().entries.map((entry) {
      var cat = entry.value;
      return Expanded(
        flex: 1,
        child: CategoryCard(
          cat,
          availableWidth: availableWidth,
          availableHeight: availableWidth,
          onTap: () {
            context.addEvent(CategoryScreenEvent(
                guid: cat.seName, isSearch: false, isService: true));
          },
        ),
      );
    }).toList();
    return Column(children: getGridRowsList(rowCount, list, availableWidth));
  }

  @override
  Widget build(BuildContext context) {
    homePageViewModel = context.getAppScreenBloc().data;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      rowCount = 4;
    } else {
      rowCount = 3;
    }
    availableWidth = (AppTheme.fullWidth(context) - 32) / rowCount;
    var body = List<Widget>();
    body.add(
      Text('Choose Your Service', style: TextConstants.P5),
    );
    body.add(Text('How can we help you today?', style: TextConstants.H5));
    body.add(LayoutConstants.sizedBox20H);
    if (homePageViewModel?.services != null) {
      var facilitiesManagement = getFacilitiesManagementServicesSlider();
      body.add(facilitiesManagement);
      body.add(LayoutConstants.sizedBox15H);
    }
    //var fun = () => getDashBoardData(forceNetwork: true);
    var containerBody = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: body,
    );
    return CategoryHomeScreen(
      sliderContentList: getSliderContentList(),
      body: containerBody.children,
      scaffoldKey: _scaffoldKey,
      showBackButton: true,
      screenTitle: GeneralStrings.FACILITY_MANAGEMENT_TITLE,
    );
  }
}
