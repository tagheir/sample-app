import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class LayoutConstants {
  // Sized Boxes
  static const SizedBox sizedBox5H = const SizedBox(height: 5.0);
  static const SizedBox sizedBox10H = const SizedBox(height: 10.0);
  static const SizedBox sizedBox15H = const SizedBox(height: 15.0);
  static const SizedBox sizedBox20H = const SizedBox(height: 20.0);
  static const SizedBox sizedBox25H = const SizedBox(height: 25.0);
  static const SizedBox sizedBox30H = const SizedBox(height: 30.0);
  static const SizedBox sizedBox35H = const SizedBox(height: 35.0);
  static const SizedBox sizedBox40H = const SizedBox(height: 40.0);
  static const SizedBox sizedBox45H = const SizedBox(height: 45.0);
  static const SizedBox sizedBox50H = const SizedBox(height: 50.0);
  static const SizedBox sizedBox100H = const SizedBox(height: 100.0);
  static const SizedBox sizedBox200H = const SizedBox(height: 200.0);
  static const SizedBox sizedBox300H = const SizedBox(height: 300.0);

  static const SizedBox sizedBox5W = const SizedBox(width: 5.0);
  static const SizedBox sizedBox10W = const SizedBox(width: 10.0);
  static const SizedBox sizedBox15W = const SizedBox(width: 15.0);
  static const SizedBox sizedBox20W = const SizedBox(width: 20.0);
  static const SizedBox sizedBox25W = const SizedBox(width: 25.0);
  static const SizedBox sizedBox30W = const SizedBox(width: 30.0);

  /* EdgeInsets */
  static const EdgeInsetsGeometry edgeInsets0 = const EdgeInsets.all(0);
  static const EdgeInsetsGeometry edgeInsets2 = const EdgeInsets.all(2);
  static const EdgeInsetsGeometry edgeInsets4 = const EdgeInsets.all(4);
  static const EdgeInsetsGeometry edgeInsets8 = const EdgeInsets.all(8);
  static const EdgeInsetsGeometry edgeInsets16 = const EdgeInsets.all(16);
  static const EdgeInsetsGeometry edgeInsets24 = const EdgeInsets.all(24);
  static const EdgeInsetsGeometry edgeInsets32 = const EdgeInsets.all(32);
  // EdgeInsets Top
  static const EdgeInsetsGeometry edgeInsetsTop5 =
      const EdgeInsets.only(top: 5);
  static const EdgeInsetsGeometry edgeInsetsTop10 =
      const EdgeInsets.only(top: 10);
  static const EdgeInsetsGeometry edgeInsetsTop15 =
      const EdgeInsets.only(top: 15);
  static const EdgeInsetsGeometry edgeInsetsTop20 =
      const EdgeInsets.only(top: 20);
  static const EdgeInsetsGeometry edgeInsetsTop25 =
      const EdgeInsets.only(top: 25);
  static const EdgeInsetsGeometry edgeInsetsTop30 =
      const EdgeInsets.only(top: 30);
  static const EdgeInsetsGeometry edgeInsetsTop35 =
      const EdgeInsets.only(top: 35);
  static const EdgeInsetsGeometry edgeInsetsTop40 =
      const EdgeInsets.only(top: 40);
  static const EdgeInsetsGeometry edgeInsetsTop45 =
      const EdgeInsets.only(top: 45);
  static const EdgeInsetsGeometry edgeInsetsTop50 =
      const EdgeInsets.only(top: 50);

  // EdgeInsets Horizontal
  static const EdgeInsetsGeometry edgeInsetsH25 =
      const EdgeInsets.symmetric(horizontal: 25);

  static const EdgeInsetsGeometry edgeInsets6H12V =
      const EdgeInsets.symmetric(vertical: 12, horizontal: 6);

  // Border Radius Shape
  static ShapeBorder shapeBorderRadius10 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  static ShapeBorder shapeBorderRadius8 =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

  static BorderRadiusGeometry borderRadius =
      BorderRadius.all(Radius.circular(8));

  static Radius borderRadius8 = Radius.circular(8);
  static Radius borderRadius4 = Radius.circular(4);

  // Card Decoration

  static BoxDecoration boxDecoration = BoxDecoration(
    color: LightColor.background,
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppTheme.lightTheme.dividerColor,
        offset: Offset(4, 4),
        blurRadius: 16,
      ),
    ],
  );

  static BoxDecoration boxDecorationWithTopRadius = BoxDecoration(
    color: LightColor.white,
    borderRadius: BorderRadius.only(
      topLeft: LayoutConstants.borderRadius8,
      topRight: LayoutConstants.borderRadius8,
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppTheme.lightTheme.dividerColor,
        offset: Offset(4, 4),
        blurRadius: 16,
      ),
    ],
  );

  static List<Widget> getAppBarActions(
    BuildContext context, {
    bool showSearchIcon = false,
    bool iconColorPrimary = false,
    bool showProfileIcon = false,
    bool showHomeIcon = false,
  }) {
    var searchButton;
    if (showSearchIcon) {
      searchButton = IconButton(
        icon: IconShadowWidget(
            Icon(Icons.search,
                color: iconColorPrimary
                    ? AppTheme.lightTheme.primaryColor
                    : Colors.white,
                size: 30),
            shadowColor: LightColor.lightBlack),
        onPressed: () {
          context.getAppBloc().add(StoreSearchEvent());
        },
      );
    }
    var homeIcon = IconButton(
      onPressed: () => context.addEvent(DashboardScreenEvent()),
      iconSize: 28,
      icon: IconShadowWidget(
        Icon(Icons.home,
            color: iconColorPrimary
                ? AppTheme.lightTheme.primaryColor
                : Colors.white),
        shadowColor: LightColor.lightBlack,
      ),
    );
    var profileIcon = IconButton(
        onPressed: () => context.addEvent(CustomerProfileViewEvent()),
        iconSize: 28,
        icon: IconShadowWidget(
            Icon(Icons.person,
                color: iconColorPrimary
                    ? AppTheme.lightTheme.primaryColor
                    : Colors.white),
            shadowColor: LightColor.lightBlack));
    var list = List<Widget>();
    if (showSearchIcon == true) {
      list.add(searchButton ?? Text(''));
    }
    if (showProfileIcon == true) {
      list.add(profileIcon ?? Text(''));
    }
    if (showHomeIcon == true) {
      list.add(homeIcon ?? Text(''));
    }
    return list;
  }
}

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets setTop(double value) {
    return this.add(EdgeInsets.only(top: value - this.top));
  }

  EdgeInsets setBottom(double value) {
    return this.add(EdgeInsets.only(bottom: value - this.bottom));
  }

  EdgeInsets setLeft(double value) {
    return this.add(EdgeInsets.only(left: value - this.left));
  }

  EdgeInsets setRight(double value) {
    return this.add(EdgeInsets.only(right: value - this.right));
  }
}
