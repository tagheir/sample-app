import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/page_view_data.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/shared/move_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// ignore: must_be_immutable
class CategoryHomeScreen extends StatefulWidget {
  final List<Widget> body;
  final List<SliderViewDto> sliderContentList;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final showBackButton;
  final String screenTitle;
  bool showSearchButton = false;
  bool showSearchBar = true;
  bool showAppBar = true;

  CategoryHomeScreen({
    Key key,
    this.body,
    this.sliderContentList,
    this.scaffoldKey,
    this.showBackButton,
    this.showSearchButton,
    this.screenTitle,
    this.showSearchBar,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  _CategoryHomeScreenState createState() => _CategoryHomeScreenState();
}

class _CategoryHomeScreenState extends State<CategoryHomeScreen> {
  ScrollController scrollController = ScrollController();
  String title = "";

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset > context.getHeight(height: 30)) {
        setState(() {
          title = widget.screenTitle;
        });
      } else {
        setState(() {
          title = "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.showSearchButton = widget.showSearchButton ?? false;
    return Material(child: getBannerSlider(context));
  }

  getBannerSlider(BuildContext context) {
    var imagesContainer = getHeaderSliderContainer();
    var body = CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        getAppBar(context, imagesContainer),
        getBody(),
      ],
    );
    return LayoutScreen(
      childView: body,
      showAppbar: false,
      scaffoldKey: widget.scaffoldKey,
      moveBackBtnColor: LightColor.white,
    );
  }

  SliverList getBody() {
    return SliverList(
      // Use a delegate to build items as they're scrolled on screen.
      delegate: SliverChildListDelegate([
        Padding(
          padding: EdgeInsets.only(top: 24, bottom: 16, left: 8, right: 8),
          child: Column(
            children: widget.body,
          ),
        )
      ]),
    );
  }

  SliverAppBar getAppBar(BuildContext context, Widget imagesContainer) {
    return SliverAppBar(
      leading: getAppBarLeadingWidget(),
      actions: LayoutConstants.getAppBarActions(
        context,
        showSearchIcon: widget.showSearchButton,
        showProfileIcon: true,
        showHomeIcon: true,
      ),
      elevation: 0,
      expandedHeight: context.getHeight(height: 40),
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: imagesContainer,
      backgroundColor: widget.showAppBar == true
          ? AppTheme.lightTheme.primaryColor
          : LightColor.white,
    );
  }

  Widget getAppBarLeadingWidget() {
    if (widget.showBackButton != true) return null;
    return MoveBackButton(
      scaffoldKey: widget.scaffoldKey,
      color: LightColor.white,
    );
  }

  Widget getHeaderSliderContainer() {
    if (widget.showAppBar != true) {
      //print("NO APP BAR");
      return Container(
        color: LightColor.white.withOpacity(0.0),
        child: FlexibleSpaceBar(
          background: getImageSlider(),
        ),
      );
    }
    return Container(
      color: AppTheme.lightTheme.primaryColor,
      child: FlexibleSpaceBar(
        title:
            Text(title, style: TextConstants.H5.apply(color: LightColor.white)),
        background: getImageSlider(),
      ),
    );
  }

  getImageSlider() {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (widget.sliderContentList[index].onClick != null) {
                  widget.sliderContentList[index].onClick();
                }
              },
              child: widget.sliderContentList[index].assetsImageWidget,
            ),
            getBannerTitle(widget.sliderContentList[index].titleText),
          ],
        );
      },
      itemCount: widget.sliderContentList.length,
      autoplay: widget.sliderContentList.length > 1,
      layout: SwiperLayout.DEFAULT,
      pagination: widget.sliderContentList.length > 1
          ? SwiperPagination(
              //margin: EdgeInsets.all(30),
              builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: Colors.white,
              ),
            )
          : null,
    );
  }

  Positioned getBannerTitle(String title) {
    return Positioned(
      bottom: 40,
      left: 16,
      child: Opacity(
        opacity: 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                title,
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
          ],
        ),
      ),
    );
  }
}
