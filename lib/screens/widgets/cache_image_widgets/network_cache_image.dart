import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NetworkCacheImage extends StatefulWidget {
  String imageUrl;
  final double width;
  final double height;

  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;

  final BoxShape shape;

  final String altImageUrl;

  NetworkCacheImage(
      {Key key,
      this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.borderRadius,
      this.shape,
      this.altImageUrl})
      : super(key: key);
  @override
  _NetworkCacheImageState createState() => _NetworkCacheImageState();
}

class _NetworkCacheImageState extends State<NetworkCacheImage> {
  @override
  Widget build(BuildContext context) {
    //////print(widget.imageUrl);
    return CachedNetworkImage(
      fit: widget.fit,
      height: widget.height,
      width: widget.width,
      imageUrl: widget.imageUrl == null ? widget.altImageUrl : widget.imageUrl,
      placeholder: (context, url) => Center(
        child: Center(child: LoadingIndicator()),
      ),
      errorWidget: (context, url, error) {
        return CachedNetworkImage(
          fit: widget.fit,
          height: widget.height,
          width: widget.width,
          imageUrl: widget.altImageUrl,
          placeholder: (context, url) => Center(
            child: Center(
              child: LoadingIndicator(),
            ),
          ),
          errorWidget: (context, url, error) {
            widget.imageUrl = widget.altImageUrl;
            return Icon(Icons.error);
          },
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration(ImageProvider imageProvider) {
    if (widget.borderRadius != null) {
      return BoxDecoration(
        borderRadius: widget.borderRadius,
        image: DecorationImage(
          image: imageProvider,
          fit: widget.fit,
        ),
      );
    } else if (widget.shape != null) {
      return BoxDecoration(
        shape: widget.shape,
        image: DecorationImage(
          image: imageProvider,
          fit: widget.fit,
        ),
      );
    } else {
      return BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: widget.fit,
        ),
      );
    }
  }
}
