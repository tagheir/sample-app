import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

class MaintenancePackageCompactView extends StatelessWidget {
  final ProductDto product;
  const MaintenancePackageCompactView({
    Key key,
    this.product,
  }) : super(key: key);

  static MaintenancePackageCompactView transform(ProductDto dto) {
    return MaintenancePackageCompactView(product: dto);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        context.addEvent(
          ProductDetailViewEvent(seName: product.seName, isCardProduct: false),
        )
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: LayoutConstants.borderRadius,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: LightColor.darkGrey,
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: Offset(0.5, 1.0),
            )
          ],
        ),
        width: AppTheme.fullHeight(context) * 0.28,
        child: Column(
          children: <Widget>[
            LayoutConstants.sizedBox15H,
            // SvgPicture.asset("assets/images/package.svg",
            //     color: Colors.black, width: 40.0, height: 40.0),
            LayoutConstants.sizedBox15H,
            Text(product.name, style: TextConstants.H3),
            Divider(color: LightColor.orange, height: 5, thickness: 3)
                .padding(AppTheme.padding),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                'Starting at',
                style: TextConstants.P6_5,
              ),
            ),
            LayoutConstants.sizedBox5H,
            RichText(
              text: TextSpan(
                  text: GeneralStrings.Currency + product.price.toString(),
                  style: TextConstants.H6_5.apply(color: LightColor.orange),
                  children: <TextSpan>[
                    TextSpan(text: '/month', style: TextConstants.H6_5)
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
