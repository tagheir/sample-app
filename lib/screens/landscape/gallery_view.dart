import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryViewScreen extends StatefulWidget {
  final int currentIndex;
  final String title;
  final List<String> imagePaths;

  GalleryViewScreen(
      {Key key,
      @required this.imagePaths,
      @required this.currentIndex,
      @required this.title})
      : super(key: key);

  @override
  _GalleryViewScreenState createState() => _GalleryViewScreenState();
}

class _GalleryViewScreenState extends State<GalleryViewScreen> {
  int _currentIndex;
  PageController _pageController;
  CarouselController carouselController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    var body = Material(
      //backgroundColor: LightColor.white,
      child: _buildContent(),
    );
    return LayoutScreen(
      scaffoldKey: scaffoldKey,
      showAppbar: true,
      screenTitle: widget.title,
      childView: body,
      showNavigationBar: false,
      backgroundColor: Colors.black,
      showHeaderCartButton: false,
      showHeaderProfileIcon: false,
      showHeaderHomeIcon: false,
      showFloatingButton: false,
    );
  }

  Widget _buildContent() {
    return Stack(
      children: <Widget>[
        buildPhotoViewGallery(),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() {
    return Positioned(
      bottom: 10.0,
      left: 0.0,
      right: 0.0,
      // child: buildDottedIndicator(),
      child: buildImageCarouselSlider(),
    );
  }

  Widget buildImageCarouselSlider() {
    if (carouselController == null) carouselController = CarouselController();

    return CarouselSlider.builder(
      itemCount: widget.imagePaths.length,
      carouselController: carouselController,
      itemBuilder: (BuildContext context, int index) {
        return ImageThumbnailWidget(
          imagePath: widget.imagePaths[index],
          onImageTap: () {
            _pageController.jumpToPage(index);
            carouselController.animateToPage(index,
                duration: Duration(milliseconds: 500));
          },
        );
      },
      options: CarouselOptions(
          // height: 100,
          aspectRatio: 4.5,
          viewportFraction: 0.20,
          autoPlay: true,
          enlargeCenterPage: true,
          onPageChanged: (index, pageChangedReason) {
            _pageController.jumpToPage(index);
          },
          initialPage: _currentIndex),
    );
  }

  Row buildDottedIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.imagePaths
          .map<Widget>((String imagePath) => _buildDot(imagePath))
          .toList(),
    );
  }

  Container _buildDot(String imagePath) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == widget.imagePaths.indexOf(imagePath)
            ? Colors.white
            : Colors.grey.shade700,
      ),
    );
  }

  PhotoViewGallery buildPhotoViewGallery() {
    return PhotoViewGallery.builder(
      itemCount: widget.imagePaths.length,
      backgroundDecoration: BoxDecoration(color: Colors.black),
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
        carouselController.animateToPage(index,
            duration: Duration(milliseconds: 500));
      },
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions.customChild(
          child: ContainerCacheImage(
            imageUrl: widget.imagePaths[index],
            persist: false,
            fit: BoxFit.contain,
          ),
          // imageProvider: NetworkImage(widget.imagePaths[index]),
          // childSize: Size(MediaQuery.of(context).size.width,
          //     MediaQuery.of(context).size.height),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
        );

        // PhotoViewGalleryPageOptions(
        //   imageProvider: NetworkImage(widget.imagePaths[index]),
        //   minScale: PhotoViewComputedScale.contained * 0.8,
        //   maxScale: PhotoViewComputedScale.covered * 1.8,
        // );
      },
      // enableRotation: true,
      scrollPhysics: const BouncingScrollPhysics(),
      pageController: _pageController,
      loadingBuilder: (BuildContext context, ImageChunkEvent event) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ImageThumbnailWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onImageTap;

  const ImageThumbnailWidget(
      {Key key, @required this.imagePath, @required this.onImageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: onImageTap,
                  child: Container(
                    child: ContainerCacheImage(
                      imageUrl: imagePath,
                      fit: BoxFit.cover,
                      persist: true,
                    ),
                  ))
              // Ink.image(
              //   image: AssetImage(imagePath),
              //   fit: BoxFit.cover,
              //   child: InkWell(onTap: onImageTap),
              // ),
              ),
        ),
      ),
    );
  }
}
