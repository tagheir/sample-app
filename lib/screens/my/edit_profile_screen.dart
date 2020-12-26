import 'dart:io';

import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_bloc.dart';
import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/models/app_screen_bloc_models/screen_data.dart';
import 'package:bluebellapp/models/customer_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custom_progress_dialog.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/custome_alert_dialog.dart';
import 'package:bluebellapp/services/base64_encode_service.dart';
import 'package:bluebellapp/services/form_validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ViewAndEditProfile extends StatefulWidget {
  @override
  _ViewAndEditProfileState createState() => _ViewAndEditProfileState();
}

class _ViewAndEditProfileState extends State<ViewAndEditProfile> {
  File selectedFile;
  CustomerDto myInfo;
  bool isDataLoaded = false;
  CustomProgressDialog pr;
  BuildContext cntxt;
  App appBloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AppScreenBloc appScreenBloc;
  ProfileScreenData profileScreenData;

  Widget getImageWidget() {
    if (selectedFile != null) {
      return Image.file(
        selectedFile,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else {
      return myInfo?.imageUrl == null
          ? ContainerCacheImage(
              altImageUrl: "https://placehold.it/100",
              imageUrl: "https://placehold.it/100",
              borderRadius: LayoutConstants.borderRadius,
              fit: BoxFit.fill,
            )
          : ContainerCacheImage(
              altImageUrl: "https://placehold.it/100",
              imageUrl: myInfo.imageUrl,
              fit: BoxFit.fill,
              borderRadius: LayoutConstants.borderRadius,
            );
    }
  }

  getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    //This function is for getting the image from
    // camera or gallery
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 0.5, ratioY: 0.5),
        //compressQuality: 100,
        compressQuality: 50,
        maxHeight: 100,
        maxWidth: 100,
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarWidgetColor: Colors.white,
            toolbarColor: ThemeScheme.lightTheme.primaryColor,
            toolbarTitle: "bluebell",
            statusBarColor: ThemeScheme.lightTheme.primaryColor,
            backgroundColor: Colors.white),
      );
      this.setState(() {
        selectedFile = cropped;
        Navigator.pop(context);
      });
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  updateCustomerInfo() {
    if (selectedFile != null && myInfo != null) {
      myInfo.imageBase64 = EncodeToBase64.encodeImage(image: selectedFile);
    }
    if (formKey.currentState.validate()) {
      profileScreenData.customerDto = myInfo;
      appScreenBloc.add(AppScreenRequestEvent(
          function: profileScreenData.updateCustomerInfo));
    }
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Profile', style: TextConstants.H6_5),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    appBloc = context.getAppBloc();
    appScreenBloc = context.getAppScreenBloc();
    if (cntxt == null) {
      cntxt = context;
    }
    myInfo = context.getAppScreenBloc().data;
    myInfo.phoneNumber = myInfo.phoneNumber.trim().replaceAll("+92", "");
    profileScreenData = ProfileScreenData(appBloc);
    appScreenBloc.onRequestResponseFunction = (data) {
      var context = App.get().currentContext;
      if (data != null) {
        CustomAlertDialog.showNew(cntxt: context, text: 'Profile Updated !');
        Future.delayed(Duration(seconds: 4), () {
          context.getAppBloc().moveBack(context, rebuild: true);
        });
      } else {
        CustomAlertDialog.showNew(
            cntxt: context, text: 'Profile update fail. Try again !');
      }
    };
    return LayoutScreen(
      isAppScreenBloc: true,
      bottomBarType: BottomBarType.Profile,
      scaffoldKey: scaffoldKey,
      showNavigationBar: false,
      showFloatingButton: false,
      // bottomBar: FixedBottomButton(onTap: updateCustomerInfo, text: "Save"),
      childView: getProfileWidget(context),
      addBackButton: true,
    );
  }

  Widget getProfileWidget(BuildContext context) {
    var list = new List<Widget>();
    list.add(_title());
    list.add(
      Stack(
        children: <Widget>[
          Container(
            //color: Colors.red,
            width: 100,
            height: 100,
            child: getImageWidget(),
            decoration: BoxDecoration(
              borderRadius: LayoutConstants.borderRadius,
              // color: Colors.red
            ),
          ),
          Positioned(
            left: 80,
            top: 77,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: LayoutConstants.shapeBorderRadius8,
                      child: _getEditPictureDialogWidget(context),
                    );
                  },
                );
              },
              child: Container(
                // height: 55,
                decoration: ShapeDecoration(
                  color: AppTheme.lightTheme.primaryColor,
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(Icons.edit, color: Colors.white, size: 18
                      //color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
    list.add(SizedBox(
      height: 35,
    ));
    list.add(
      Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                myInfo.firstName = value;
              },
              validator: (value) {
                return validateFirstName(value);
              },
              maxLength: 20,
              initialValue: myInfo?.firstName,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true)
              ],
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              maxLength: 20,
              initialValue: myInfo?.lastName,
              onChanged: (value) {
                myInfo.lastName = value;
              },
              validator: (value) {
                return validateLastName(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true)
              ],
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              initialValue: myInfo?.email,
              readOnly: true,
              onChanged: (value) {
                myInfo.email = value;
              },
              validator: (value) {
                return validateEmail(value);
              },
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue:
                  myInfo?.phoneNumber == null ? "" : myInfo.phoneNumber,
              maxLength: 10,
              onChanged: (value) {
                myInfo.phoneNumber = value;
              },
              decoration: InputDecoration(
                labelText: 'Phone number',
                prefixText: '+92 ',
              ),
              validator: (value) {
                return validatePhoneNumber(value);
              },
              inputFormatters: [
                FilteringTextInputFormatter(RegExp("[0-9]"), allow: true)
              ],
            ),
            LayoutConstants.sizedBox30H,
            getSubmitButton()
          ],
        ),
      ),
    );
    list.add(LayoutConstants.sizedBox300H);
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24),
      child: ListView(
        children: [
          Container(
              child: Column(
            children: list,
          )),
        ],
      ),
    );
  }

  getSubmitButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: MaterialButton(
          minWidth: 20,
          height: 40,
          onPressed: () {
            updateCustomerInfo();
            //if (formKey.currentState.validate()) {}
          },
          color: AppTheme.lightTheme.primaryColor,
          textColor: Colors.white,
          child: Text(
            'Save',
            style: TextConstants.H6.apply(color: LightColor.white),
          ),
          shape: LayoutConstants.shapeBorderRadius8),
    );
  }

  Container _getEditPictureDialogWidget(BuildContext context) {
    return Container(
        height: 150,
        width: 100,
        child: Column(children: <Widget>[
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            // color: Colors.deepOrange,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 16),
              child: Text(
                "Choose Picture From",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: ThemeScheme.lightTheme.primaryColor),
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: LightColor.grey,
          ).padding(EdgeInsets.only(bottom: 5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              uploadImageOptionWidget(isGallery: true),
              uploadImageOptionWidget(isGallery: false),
            ],
          )
        ]));
  }

  GestureDetector uploadImageOptionWidget({bool isGallery}) {
    return GestureDetector(
      onTap: () =>
          getImage(isGallery ? ImageSource.gallery : ImageSource.camera),
      child: Column(
        children: [
          Image.network(
            isGallery
                ? "https://purepng.com/public/uploads/large/purepng.com-photos-icon-android-kitkatsymbolsiconsapp-iconsandroid-kitkatandroid-44-721522597661gzej2.png"
                : "https://icons.iconarchive.com/icons/dtafalonso/android-lollipop/256/Camera-icon.png",
            height: 45,
            width: 45,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            isGallery ? "Gallery" : "Camera",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
