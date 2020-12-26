import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/bloc/product_bloc/product_bloc.dart';
import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/repos/app_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension WidgetExtensions on Widget {
  Widget center() => Center(child: this);
  Widget borderRadius(double radius) => ClipRRect(
        child: this,
        borderRadius: LayoutConstants.borderRadius,
      );
  Widget wrap() => Wrap(children: <Widget>[this]);

  Widget expand(int flex) => Expanded(child: this, flex: flex);
  Widget padding(EdgeInsetsGeometry insets) =>
      Padding(padding: insets, child: this);
}

extension WidgetListExtensions on List<Widget> {
  Widget wrap() => Wrap(children: this);
}

extension AppBlocExtensions on BuildContext {
  App getAppBloc() {
    //////print("App From AppBloc");
    return App.get();
  }

  CategoryType getCategoryType() => App.get().categoryType;
  ProductBloc getProductBloc() => BlocProvider.of<ProductBloc>(this);

  AppScreenBloc getAppScreenBloc() => BlocProvider.of<AppScreenBloc>(this);

  void pushStateToHistory(AppState state) {}
  void addEvent(AppEvent evt) {
    App.get().currentContext = this;
    ////print("Here");
    App.get().add(evt, context: this).then((value) => null);
  }

  void addEvents(List<AppEvent> evt) {
    App.get().currentContext = this;
    ////print("Here EVENTS");
    App.get().addEvents(evt, context: this).then((value) => null);
  }

  Future<bool> moveBack({AppState returnState}) =>
      App.get().moveBack(this, returnState: returnState);
  AppRepo getRepo() => App.get().getRepo();
}

extension MediaQueryExtension on BuildContext {
  Size getScreenSize() {
    return MediaQuery.of(this).size;
  }

  double getWidth({double width = 100}) {
    return MediaQuery.of(this).size.width * width / 100;
  }

  double getHeight({double height = 100}) {
    return MediaQuery.of(this).size.height * height / 100;
  }

  double paddingTop() {
    return MediaQuery.of(this).padding.top;
  }
}

extension KeyExtensions on GlobalKey {
  App getAppBloc() => App.get();
  ProductBloc getProductBloc() =>
      BlocProvider.of<ProductBloc>(this.currentContext);

  void pushStateToHistory(AppState state) {
    //print("In Extension");
    (this.currentContext).pushStateToHistory(state);
  }

  void addEvent(AppEvent evt) => (this.currentContext).addEvent(evt);
  void moveBack() => (this.currentContext).moveBack();
  AppRepo getRepo() => (this.currentContext).getRepo();
}

extension BoolParsing on String {
  bool parseBool() {
    return this.toLowerCase() == 'true';
  }
}

extension TypeExtension on Type {
  bool isPrimitiveType() =>
      this == int ||
      this == String ||
      this == DateTime ||
      this == bool ||
      this == double;

  bool isList() => this == List;
}
