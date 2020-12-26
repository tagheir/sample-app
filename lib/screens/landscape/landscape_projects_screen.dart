import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/landscape_project_dto.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'landscape_project_card.dart';

class LandscapeProjectsScreen extends StatefulWidget {
  @override
  _LandscapeProjectsScreenState createState() =>
      _LandscapeProjectsScreenState();
}

class _LandscapeProjectsScreenState extends State<LandscapeProjectsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double availableWidth;
  Widget body;
  List<LandscapeProjectDto> projectsList;
  @override
  Widget build(BuildContext context) {
    availableWidth = MediaQuery.of(context).size.width - 16;
    projectsList = context.getAppScreenBloc().data;
    var projectCards = projectsList
        .map((e) => LandscapeProjectCard(
              title: e.name,
              location: e.address,
              imagePath: e.picturePathWithCdn.first,
              availableWidth: availableWidth,
              availableHeight: availableWidth / 1.5,
              onTap: () {
                context.addEvent(
                    LandscapeProjectImagesScreenEvent(guid: e.id.toString()));
              },
            ))
        .toList();
    body = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 8, top: 24),
      child: ListView(children: projectCards),
    );
    return LayoutScreen(
      childView: body,
      showAppbar: true,
      screenTitle: GeneralStrings.LANDSCAPE_PROJECTS,
      scaffoldKey: scaffoldKey,
      showNavigationBar: false,
      showQuoteButton: true,
      showHeaderCartButton: true,
    );
  }
}
