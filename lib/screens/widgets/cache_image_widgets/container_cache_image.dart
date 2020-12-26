import 'dart:io';

import 'package:bluebellapp/resources/constants/general_constants.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
import 'package:bluebellapp/services/local_images_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContainerCacheImage extends StatefulWidget {
  String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;
  final BoxShape shape;
  final String altImageUrl;
  final Color color;
  final bool useAsBackground;
  final bool persist;
  final bool ignoreLocal;
  final bool resetLocal;
  bool rebuildImage;
  Widget imageFinalized;

  ContainerCacheImage({
    Key key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.shape,
    this.altImageUrl,
    this.color,
    this.persist = true,
    this.rebuildImage = false,
    this.ignoreLocal = false,
    this.resetLocal = false,
    this.useAsBackground = true,
  }) : super(key: key);
  @override
  _ContainerCacheImageState createState() => _ContainerCacheImageState();
}

class _ContainerCacheImageState extends State<ContainerCacheImage> {
  File imageFile;
  bool isNetworkImage = true;
  String localImagePath;
  File localImageFile;
  bool localImageExistenceCheck = false;
  bool isExistLocally = false;
  bool isFailedToSave = false;
  @override
  Widget build(BuildContext context) {
    //print(widget.imageUrl);
    //print(widget.imageFinalized);
    try {
      if (widget.imageFinalized != null && !widget.rebuildImage) {
        return widget.imageFinalized;
      } else {}
      if (widget.persist) {
        if (localImagePath == null) {
          var directoryPath = GeneralConstants.directoryPath;
          localImagePath = LocalImageService.transformToLocalPath(
            widget.imageUrl,
            directoryPath,
          );
        }
        //print("h1");
        if (!localImageExistenceCheck && localImagePath != null) {
          processForLocalImage();
          return Container(
            width: widget.width,
            height: widget.height,
            child: LoadingIndicator(),
          );
        }
        //print("h2");
        if (!widget.ignoreLocal && !isFailedToSave && !widget.rebuildImage) {
          if (isExistLocally) {
            loadLocalImageForLocalImage();
            ////////////print("LOCAL RUN => ---- " + localImagePath);

            // CachedNetworkImage(imageUrl: widget.imageUrl)
            //     .cacheManager
            //     .getSingleFile(widget.imageUrl)
            //     .then((File value) {
            //   //////////print(value.absolute);
            //   //////////print(value.path);
            // });
            // Image.file(
            //   localImageFile,
            //   width: widget.width,
            //   height: widget.height,
            // );
            if (widget.useAsBackground) {
              widget.imageFinalized = Container(
                width: widget.width,
                height: widget.height,
                decoration: buildBoxDecoration(FileImage(localImageFile)),
              );
            } else {
              widget.imageFinalized = Image.file(
                localImageFile,
                width: widget.width,
                height: widget.height,
              );
              // FileImage(localImageFile)
            }

            if (widget.imageFinalized == null) {
              //////print("------------- imageFinalized NULL !!!!");
            } else {
              //////print("-------------- imageFinalized NOT NULL !!!!");
            }
            return widget.imageFinalized;
          } else {
            ////////////print("WENT TO SAVE LOCALLY");
            LocalImageService.saveImageToPath(widget.imageUrl, localImagePath)
                .then((status) {
              //////print("CAME FROM SAVE LOCALLY => " + status.toString());
              setState(() {
                if (status) {
                  isExistLocally = true;
                } else {
                  isFailedToSave = true;
                }
              });
            });
            return Container(
              width: widget.width,
              height: widget.height,
              child: LoadingIndicator(),
            );
          }
        }
      }
      //print("h3");
      if (widget.imageUrl != null) {
        if (!(widget.imageUrl.contains("https"))) {
          isNetworkImage = false;
          imageFile = new File(widget.imageUrl);
          imageFile.readAsBytes();
        }
      }
      //print("h4");
      return isNetworkImage
          ? CachedNetworkImage(
              fit: widget.fit,
              imageBuilder: (context, imageProvider) {
                widget.imageFinalized = Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: buildBoxDecoration(imageProvider),
                );
                return widget.imageFinalized;
              },
              imageUrl: widget.imageUrl == null
                  ? widget.altImageUrl
                  : widget.imageUrl,
              placeholder: (context, url) => Center(
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  child: LoadingIndicator(),
                ),
              ),
              errorWidget: (context, url, error) {
                widget.imageUrl = widget.altImageUrl;

                var cacheNetworkImage = CachedNetworkImage(
                  fit: widget.fit,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: buildBoxDecoration(imageProvider),
                    );
                  },
                  imageUrl: widget.altImageUrl,
                  placeholder: (context, url) => Center(
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      child: LoadingIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    widget.imageUrl = widget.altImageUrl;

                    return Container(
                      width: widget.width,
                      height: widget.height,
                      child: Icon(Icons.error),
                    );
                  },
                );
                return cacheNetworkImage;
              },
            )
          : Container(
              width: widget.width,
              height: widget.height,
              decoration: buildBoxDecoration(FileImage(imageFile)),
            );
    } catch (e) {
      return Container(
        width: widget.width,
        height: widget.height,
        child: LoadingIndicator(),
      );
    }
  }

  processForLocalImage() {
    File(localImagePath).exists().then((value) {
      //////print("Locally Exists => " + value.toString() + " - ($localImagePath)");
      setState(() {
        isExistLocally = value;
        localImageExistenceCheck = true;
      });
    });
  }

  loadLocalImageForLocalImage() {
    if (localImageExistenceCheck && isExistLocally) {
      localImageFile = File(localImagePath);
      localImageFile.readAsBytes();
    }
  }

  BoxDecoration buildBoxDecoration(ImageProvider imageProvider) {
    return BoxDecoration(
        borderRadius: widget.borderRadius,
        color: widget.color ?? null,
        image: DecorationImage(
            image: imageProvider,
            fit: widget.fit,
            colorFilter: widget.color != null
                ? new ColorFilter.mode(
                    widget.color.withOpacity(0.2), BlendMode.dstATop)
                : null));
  }
}

// class MyDefaultCacheManager extends BaseCacheManager {
//   static const key = 'libCachedImageData';

//   static DefaultCacheManager _instance;

//   factory MyDefaultCacheManager() {
//     _instance ??= MyDefaultCacheManager._();
//     return _instance;
//   }

//   MyDefaultCacheManager._() : super(key);

//   @override
//   Future<String> getFilePath() async {}
// }
