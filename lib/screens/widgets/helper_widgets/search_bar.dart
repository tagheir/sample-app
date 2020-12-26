import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatelessWidget {
  final showFilterIcon;
  Function onFilterIconPress;
  Function onSearchSubmit;
  SearchBar(
      {Key key,
      this.showFilterIcon,
      this.onFilterIconPress,
      this.onSearchSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(
            color: HexColor("#757575").withOpacity(0.6),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.lightTheme.dividerColor,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(38)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SearchScreen(), fullscreenDialog: true),
                  // );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.search,
                      size: 18,
                      //color: AppTheme.getTheme().primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 8,
                      child: TextField(
                        maxLines: 1,
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => SearchScreen(), fullscreenDialog: true),
                        //   );
                        // },
                        enabled: true,
                        onSubmitted: (String str) {
                          onSearchSubmit(str);
                        },
                        onChanged: (String txt) {},
                        style: TextStyle(
                          fontSize: 16,
                          color: LightColor.darkGrey,
                        ),
                        cursorColor: ThemeScheme.lightTheme.primaryColor,
                        decoration: new InputDecoration(
                          errorText: null,
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                              color: AppTheme.lightTheme.disabledColor),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: showFilterIcon == true
                            ? IconButton(
                                icon: Icon(Icons.filter_list_rounded,
                                    color: AppTheme.lightTheme.primaryColor,
                                    size: 25),
                                onPressed: () {
                                  this.onFilterIconPress();
                                },
                              )
                            : Text(''))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
