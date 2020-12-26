import 'dart:async';
import 'package:bluebellapp/models/page_view_data.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class HeaderSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;
  final List<SliderViewDto> pageViewModelData;
  final double imageHeight;

  HeaderSliderView(
      {Key key,
      this.opValue = 0.0,
      this.click,
      this.pageViewModelData,
      this.imageHeight})
      : super(key: key);
  @override
  _HeaderSliderViewState createState() => _HeaderSliderViewState();
}

class _HeaderSliderViewState extends State<HeaderSliderView> {
  var pageController = PageController(initialPage: 0);
  var pageViewModelData;
  List<PagePopup> pagePopups;
  Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData = widget.pageViewModelData;

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (currentShowIndex < widget.pageViewModelData.length - 1) {
        pageController.animateTo(
            MediaQuery.of(context).size.width * (currentShowIndex + 1),
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn);
      } else {
        pageController.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
      // if (currentShowIndex == 0) {
      //   pageController.animateTo(MediaQuery.of(context).size.width * 1,
      //       duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      // } else if (currentShowIndex == 1) {
      //   pageController.animateTo(MediaQuery.of(context).size.width * 2,
      //       duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      // } else if (currentShowIndex == 2) {
      //   pageController.animateTo(0,
      //       duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      // }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer?.cancel();
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //////print("HEADER SLIDER VIEW");
    if (pagePopups == null) {
      //////print("-------------------- PAGE POPUP EMPTY ------------");
      pagePopups = List<PagePopup>();
      for (var item in widget.pageViewModelData) {
        var pagePopup = PagePopup(
          imageData: item,
          opValue: widget.opValue,
          pageHeight: widget.imageHeight,
        );
        pagePopups.add(pagePopup);
      }
    }

    return Stack(
      children: <Widget>[
        PageView(
          controller: pageController,
          pageSnapping: true,
          onPageChanged: (index) {
            currentShowIndex = index;
          },
          scrollDirection: Axis.horizontal,
          children: pagePopups,
        ),
        Positioned(
          bottom: 20,
          right: 32,
          child: PageIndicator(
            layout: PageIndicatorLayout.WARM,
            size: 10.0,
            controller: pageController,
            space: 5.0,
            count: widget.pageViewModelData.length,
            color: Colors.white,
            activeColor: AppTheme.lightTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}

class PagePopup extends StatelessWidget {
  final SliderViewDto imageData;
  final double opValue;
  final double pageHeight;
  ContainerCacheImage imageAsset;

  PagePopup({Key key, this.imageData, this.opValue: 0.0, this.pageHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageAsset == null) {
      // ////print(
      //     "-------------------------------------------CACHE IMAGE CREATION AGAIN !!!");
      imageAsset = ContainerCacheImage(
        altImageUrl: "https://placehold.it/600",
        imageUrl: imageData.assetsImage,
        borderRadius: BorderRadius.only(
            bottomLeft: LayoutConstants.borderRadius8,
            bottomRight: LayoutConstants.borderRadius8),
        // width: 500,
        // height: 200,
        fit: BoxFit.cover,
      );
    }
    return Stack(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            //////print("OnClick");
            if (imageData.onClick != null) {
              imageData.onClick();
            }
          },
          child: Container(
            height: pageHeight, //(MediaQuery.of(context).size.width * 0.6),
            width: MediaQuery.of(context).size.width,
            child: imageAsset,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    imageData.titleText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(0, 0, 0, 255),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
