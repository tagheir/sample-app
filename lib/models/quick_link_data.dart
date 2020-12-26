import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuickLinkData {
  final String title;
  final String imagePath;
  final AppEvent event;
  QuickLinkData({this.title, this.imagePath, this.event});

  static List<QuickLinkData> getQuickLinkListData() {
    var listData = List<QuickLinkData>();
    listData = [
      QuickLinkData(
          title: 'All Services',
          imagePath: "assets/images/landscape/services.png",
          event: LandscapeAllServicesScreenEvent()),
      QuickLinkData(
          title: 'Projects',
          imagePath: "assets/images/landscape/projects.jpg",
          event: LandscapeProjectsScreenViewEvent()),
      QuickLinkData(
          title: 'Shop',
          imagePath: "assets/images/landscape/shop.png",
          event: StoreHomeScreenEvent()),
      QuickLinkData(
          title: 'About',
          imagePath: "assets/images/landscape/about.png",
          event: LandscapeAboutScreenEvent()),
      QuickLinkData(
          title: 'Get Quote',
          imagePath: "assets/images/landscape/services.png",
          event: LandscapeAllServicesScreenEvent()),
    ];
    return listData;
  }
}
