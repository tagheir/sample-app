import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/landscape_project_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LandscapeProjectImagesScreen extends StatefulWidget {
  final String guid;
  LandscapeProjectImagesScreen({this.guid});
  @override
  _LandscapeProjectImagesScreenState createState() =>
      _LandscapeProjectImagesScreenState();
}

class _LandscapeProjectImagesScreenState
    extends State<LandscapeProjectImagesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool verticalGallery = false;
  Widget body;
  double availableWidth;
  LandscapeProjectDto landscapeProjectDto;
  List<String> imagePaths;
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(2, 3),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(4, 2),
  ];
  Widget getImageCard(String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        context.addEvent(
          GalleryViewEvent(
            imagePaths: imagePaths,
            currentIndex: index,
            title: landscapeProjectDto.address,
          ),
        );
      },
      child: Container(
        height: availableWidth * 0.3,
        decoration: LayoutConstants.boxDecoration,
        child: ClipRRect(
          borderRadius: LayoutConstants.borderRadius,
          child: ContainerCacheImage(
            imageUrl: imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    landscapeProjectDto = context.getAppScreenBloc().data;
    imagePaths = landscapeProjectDto.picturePathWithCdn;
    availableWidth = MediaQuery.of(context).size.width - 16;
    var imagesCards = imagePaths
        .asMap()
        .entries
        .map((entry) => getImageCard(entry.value, entry.key))
        .toList();
    body = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 8, top: 24),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        crossAxisCount: 4,
        itemCount: imagesCards.length,
        itemBuilder: (context, index) {
          return imagesCards[index];
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 3 : 2),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        padding: EdgeInsets.all(4.0),
      ),
    );
    return LayoutScreen(
      childView: body,
      scaffoldKey: scaffoldKey,
      screenTitle: landscapeProjectDto.address,
      showAppbar: true,
      showNavigationBar: false,
      showQuoteButton: true,
      showHeaderCartButton: true,
      showFloatingButton: false,
      showHeaderProfileIcon: false,
      showHeaderHomeIcon: false,
    );
  }
}
