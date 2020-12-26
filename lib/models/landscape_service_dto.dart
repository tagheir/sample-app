import 'package:bluebellapp/resources/strings/general_string.dart';

class ImageDto {
  String imagePath;
  String title;
  ImageDto({this.title, this.imagePath});
}

class LandscapeServiceDto {
  String name;
  String description;
  List<ImageDto> imagesList = List<ImageDto>();

  LandscapeServiceDto({this.name, this.description, this.imagesList});

  static List<LandscapeServiceDto> getLandscapeAllService() {
    return [
      LandscapeServiceDto(
          name: GeneralStrings.GARDEN_DESIGN,
          description: GeneralStrings.GARDEN_DESIGN_DESC,
          imagesList: [
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png')
          ]),
      LandscapeServiceDto(
          name: GeneralStrings.GARDEN_DESIGN,
          description: GeneralStrings.GARDEN_DESIGN_DESC,
          imagesList: [
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png')
          ]),
      LandscapeServiceDto(
          name: GeneralStrings.GARDEN_DESIGN,
          description: GeneralStrings.GARDEN_DESIGN_DESC,
          imagesList: [
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png')
          ]),
      LandscapeServiceDto(
          name: GeneralStrings.GARDEN_DESIGN,
          description: GeneralStrings.GARDEN_DESIGN_DESC,
          imagesList: [
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png')
          ]),
      LandscapeServiceDto(
          name: GeneralStrings.GARDEN_DESIGN,
          description: GeneralStrings.GARDEN_DESIGN_DESC,
          imagesList: [
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png')
          ]),
      LandscapeServiceDto(
          name: GeneralStrings.GARDEN_DESIGN,
          description: GeneralStrings.GARDEN_DESIGN_DESC,
          imagesList: [
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png')
          ]),
      LandscapeServiceDto(
          name: GeneralStrings.GARDEN_DESIGN,
          description: GeneralStrings.GARDEN_DESIGN_DESC,
          imagesList: [
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png'),
            ImageDto(
                title: 'Garden Design',
                imagePath: 'assets/images/core_val1.png')
          ]),
    ];
  }
}
