import 'package:bluebellapp/models/category_filter_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/button_widgets/btn_cancel.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FilterModalPopup extends StatefulWidget {
  final Function(String str) onViewSearchPress;
  final Function onClearSelection;
  FilterModalPopup({this.onViewSearchPress, this.onClearSelection});
  @override
  _FilterModalPopupState createState() => _FilterModalPopupState();
}

class _FilterModalPopupState extends State<FilterModalPopup> {
  CategoryFilterDto category;
  List<String> selectedOptions = List<String>();
  oneTimeInitialization() {
    size = AppTheme.size(context);
    category = context?.getAppScreenBloc()?.data;
    category.productSpecificationAttributeInfo.forEach((atInfo) {
      atInfo.productSpecificationAttributeInfoOptions.forEach((opInfo) {
        if (opInfo.isPreSelected == true) {
          selectedOptions.add(opInfo.id.toString());
        }
      });
    });
  }

  clearSelection() {
    category.productSpecificationAttributeInfo.forEach((ps) {
      ps.productSpecificationAttributeInfoOptions.forEach((op) {
        setState(() {
          op.isPreSelected = false;
        });
      });
    });
  }

  Column getFilterOptions(ProductSpecificationAttributeInfo attributeInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutConstants.sizedBox10H,
        Row(
          children: [
            Text(attributeInfo.name,
                textAlign: TextAlign.left,
                style: TextConstants.H5.apply(color: LightColor.navy)),
          ],
        ),
        LayoutConstants.sizedBox10H,
        Wrap(
          spacing: 8,
          children: attributeInfo.productSpecificationAttributeInfoOptions
              .map(
                (e) => FlatButtonWidget(
                  attributeInfoOption: e,
                  color: LightColor.navy,
                  onPress:
                      (ProductSpecificationAttributeInfoOption optionInfo) {
                    if (optionInfo.isPreSelected == true) {
                      selectedOptions.add(optionInfo.id.toString());
                    } else {
                      selectedOptions.remove(optionInfo.id.toString());
                    }
                  },
                ),
              )
              .toList(),
        ),
        LayoutConstants.sizedBox10H,
        Divider(
          thickness: 0.5,
          color: LightColor.grey,
        ),
      ],
    );
  }

  Size size;
  @override
  Widget build(BuildContext context) {
    oneTimeInitialization();
    return Scaffold(
      // appBar: _getAppBar(),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CancelButton(
                      context: context,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Filters',
                              textAlign: TextAlign.left,
                              style: TextConstants.H4
                                  .apply(color: LightColor.navy)),
                          LayoutConstants.sizedBox20H,
                          Divider(
                            thickness: 0.5,
                            color: LightColor.grey,
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: category.productSpecificationAttributeInfo
                                .map((e) => getFilterOptions(e))
                                .toList(),
                          )
                        ],
                      ).padding(EdgeInsets.all(16)),
                    ),
                  )
                ],
              )),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.09,
                width: size.width,
                decoration: LayoutConstants.boxDecorationWithTopRadius,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: RaisedButtonWidget(
                            text: "Clear Selection",
                            onTap: () {
                              if (selectedOptions.length > 0) {
                                clearSelection();
                                widget.onClearSelection();
                                //Navigator.of(context).pop();
                              }
                            },
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: RaisedButtonWidget(
                          text: "View Searched Results",
                          onTap: () {
                            if (selectedOptions.length > 0) {
                              String selectedOptionsString =
                                  selectedOptions.join(',');
                              widget.onViewSearchPress(selectedOptionsString);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RaisedButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  RaisedButtonWidget({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onTap();
      },
      child: Text(this.text,
          style: TextConstants.H7.apply(color: LightColor.white)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: LightColor.navy,
      shape: LayoutConstants.shapeBorderRadius8,
    );
  }
}

class FlatButtonWidget extends StatefulWidget {
  final ProductSpecificationAttributeInfoOption attributeInfoOption;
  final Color color;
  final Function onPress;
  const FlatButtonWidget(
      {Key key, this.attributeInfoOption, this.color, this.onPress})
      : super(key: key);

  @override
  _FlatButtonWidgetState createState() => _FlatButtonWidgetState();
}

class _FlatButtonWidgetState extends State<FlatButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(widget.attributeInfoOption.name),
      onPressed: () {
        setState(() {
          widget.attributeInfoOption.isPreSelected =
              widget.attributeInfoOption.isPreSelected == true ? false : true;
        });
        widget.onPress(widget.attributeInfoOption);
      },
      color: widget.attributeInfoOption.isPreSelected == true
          ? widget.color
          : LightColor.white,
      textColor: widget.attributeInfoOption.isPreSelected == true
          ? LightColor.white
          : widget.color,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: widget.color,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
