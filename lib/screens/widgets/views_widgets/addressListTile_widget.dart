import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';

class AddressListTile extends StatefulWidget {
  final CustomerAddressDto add;
  final int value;
  int groupValue;
  Function callBack;
  AddressListTile({this.add, this.value, this.groupValue, this.callBack});

  @override
  _AddressListTileState createState() => _AddressListTileState();
}

class _AddressListTileState extends State<AddressListTile> {
  @override
  Widget build(BuildContext context) {
    //int customselectedRadioTile = 0;

    return RadioListTile(
      value: widget.value,
      groupValue: widget.groupValue,
      onChanged: null,
      title: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.add.firstName +
                        (widget.add.lastName.isNotEmpty
                            ? ' ' + widget.add.lastName
                            : ''),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        widget.callBack();
                      },
                      child:
                          Icon(Icons.edit, color: LightColor.orange, size: 25))
                ],
              ),
            )
          ],
        ),
      ),
      subtitle: Text(
        widget.add.address1 +
            (widget.add.city.isNotEmpty ? ', ' + widget.add.city : ''),
        style:
            TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w400),
      ),
    );
  }
}
