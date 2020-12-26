import 'dart:convert';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/services/local_images_service.dart';
import 'package:bluebellapp/resources/constants/helper_constants/template_type.dart';
import 'category_info_dto.dart';

class CategoryCompactDto extends CategoryInfoDto {
  List<CategoryCompactDto> subCategories;
  List<ProductDto> products;

  CategoryCompactDto(
      {List<CategoryCompactDto> subCategories,
      List<ProductDto> products,
      String description,
      String templateTypeName,
      String backgroundUrl,
      String title,
      String bannerUrl,
      String seName})
      : super(
            title: title,
            description: description,
            templateTypeName: templateTypeName,
            backgroundUrl: backgroundUrl,
            bannerUrl: backgroundUrl,
            seName: seName) {
    this.subCategories = subCategories;
    this.products = products;
  }

  static CategoryCompactDto getLandscapeAllServicesModel() =>
      CategoryCompactDto(
          subCategories: [
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Garden Design",
                      seName: "garden-design-service",
                      templateTypeName: TemplateType.Landscape,
                      price: 0,
                      pictures: [
                        "assets/images/landscape/1- Garden design.jpg"
                      ])
                ],
                description:
                    " <p>Garden design is the foundation of any great landscape. What does your dream garden look like? Make your vision a reality with the help of our garden design secrets, ideas, and inspiration for your green areas. We are known for our naturalistic plantings that grow into lush, inviting gardens. Each is designed and built to perfectly suit the setting, whether as a focal point or as a backdrop and to be ultimately manageable. We always pay close attention to the adaptability of garden plants, both native and introduced, that easily survive drought, heat and cold.</p>\r\n ",
                templateTypeName: null,
                backgroundUrl: null,
                title: "Garden Design",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005505_garden-design.jpg",
                seName: "garden-design"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Garden Installation",
                      seName: "garden-installation-service",
                      templateTypeName: TemplateType.Landscape,
                      price: 0,
                      pictures: [
                        "assets/images/landscape/1- Garden Installtion.jpg"
                      ]),
                  ProductDto(
                      name: "Garden Removal",
                      seName: "garden-removal-service",
                      templateTypeName: TemplateType.Landscape,
                      price: 0,
                      pictures: [
                        "assets/images/landscape/2- Garden removal.jpg"
                      ])
                ],
                description:
                    " <p>Whether you are looking to plant a small perennial garden or a mile-long driveway with large trees, we have the expertise and experience to do it, and to do it right. Your project will have our full attention from start to finish</p>\r\n ",
                templateTypeName: null,
                backgroundUrl: null,
                title: "Garden Installation or Removal",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005515_garden-installation-or-removal.jpg",
                seName: "garden-installation-or-removal"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Garden Restoration",
                      seName: "garden-restoration-service",
                      templateTypeName: TemplateType.Landscape,
                      price: 0,
                      pictures: [
                        "assets/images/landscape/3- Garden restoration.jpg"
                      ])
                ],
                description:
                    " <p>Garden restoration is one of the specialist services provided by bluebell. We are passionate on restoring gardens to their former glory, whether returning a densely overgrown border to a flowering shrubbery, pruning a tangled wisteria to encourage flowering, rediscovering a historic landscape or simply clearing brambles to restore a wildflower meadow, our teams have the experience and expertise to undertake a variety of garden restoration projects large and small. </p> ",
                templateTypeName: null,
                backgroundUrl: null,
                title: "Garden Restoration",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005514_garden-restoration.jpg",
                seName: "garden-restoration"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Garden Maintenance",
                      seName: "garden-maintenance-service",
                      templateTypeName: TemplateType.Landscape,
                      price: 0,
                      pictures: [
                        "assets/images/landscape/4-Garden-maintenance.jpg"
                      ])
                ],
                description:
                    "  <p>We have a large variety of plants to choose from, and we are sure we can find the right assortment to meet your needs. The plants that were originally landscaped in your garden may not be the verity for the sunlight or soil quality. If your landscaping is not properly fertilized, then the plants may stunt in growth or acquire a disease. bluebell Services will do an assessment for you at any time free of charge. </p>  ",
                templateTypeName: null,
                backgroundUrl: null,
                title: "Garden Maintenance",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005635_1000-by-1000-28-2-.jpeg",
                seName: "garden-maintenance-2"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Seasonal Clean-Ups",
                      seName: "seasonal-clean-ups-service",
                      templateTypeName: TemplateType.Landscape,
                      price: 0,
                      pictures: [
                        "assets/images/landscape/5- Seasonal Cleanups.jpg"
                      ])
                ],
                description:
                    "   <p>Keep your garden healthy all year long with our Seasonal Cleanup Programs. As we all know, plants change and adapt as the seasons go by. Sometimes they are unable to endure the ravages of Spring, Autumn, Summer, and Winter, though most plants are resilient if given the opportunity. The fact is that plants are often not given a fighting chance. We don’t do this on purpose certainly, but letting nature take its course can certainly have ill effects on your garden. However, with bluebell help, you won’t have to worry about dealing with the changes and issues that the seasons bring with them. By helping you clean up your yard or common areas in the seasons we’ll help ensure the continued success and resilience of your plants and your overall space. Dealing with the issues of seasonal changes can be stressful, but with our help, you’ll never have to worry again. Simply call us and we’ll do the rest. </p>   ",
                title: "Seasonal Clean-Ups",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005512_seasonal-clean-ups.jpg",
                seName: "seasonal-clean-ups"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Trimming",
                      seName: "trimming-service",
                      pictures: ["assets/images/landscape/6- Trimming.jpg"])
                ],
                description:
                    " <p>We know that mowers can’t get to all the grass in your garden. That’s why we make sure to trim and edge around your driveways, sidewalks, trees, plants and anywhere else it may be needed in your garden. Our goal is to give your garden a polished look. </p> ",
                title: "Trimming ",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005518_trimming.jpg",
                seName: "trimming-1"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Blowing",
                      seName: "blowing-service",
                      pictures: ["assets/images/landscape/7-Blowing.jpg"])
                ],
                description:
                    " <p>Our power blowing services get in those hard to reach places like under shrubs and trees. We make sure that all the excess debris in your garden is taken care of. Most clippings are blown back into the turf to return nutrients back into the soil. Excess clippings and debris will be removed leaving your driveways and sidewalks clean.</p> ",
                title: "Blowing",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005510_blowing.jpg",
                seName: "blowing"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Hedge Pruning",
                      seName: "hedge-pruning-service",
                      pictures: [
                        "assets/images/landscape/1- Hedge pruning.jpg"
                      ]),
                  ProductDto(
                      name: "Shrub Pruning",
                      seName: "shrub-pruning-service",
                      pictures: ["assets/images/landscape/2-Shrub pruning.jpg"])
                ],
                description:
                    "  <p>There are three major types of pruning aesthetic, productive, and practical.</p>\r\n\r\n<p><strong>Aesthetic Pruning</strong> is done to improve the appearance of a tree or shrub. Most aesthetic pruning is done to create or maintain both symmetry and a desired shape and height. Artistic aesthetic pruning can also be done on hedges and shrubs to create very interesting topiary designs.</p>\r\n\r\n<p><strong>Productive Pruning</strong> is the process of removing non-productive limbs or stems from trees and plants so that more energy goes to the productive parts of the plants.</p>\r\n\r\n<p><strong>Practical Pruning</strong> is the process of removing limbs or branches that would otherwise interfere with power lines, walkways, decks, or other structures. We also consider the removal of interfering limbs and branches as &ldquo;practical pruning&rdquo; because such preventive measures often improve the tree&rsquo;s or shrub&rsquo;s health and help prevent damage.</p>  ",
                title: "Hedge & Shrub Pruning",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005511_hedge-shrub-pruning.jpg",
                seName: "hedge-and-shrub-pruning"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Tree Trimming",
                      seName: "tree-trimming-service",
                      pictures: [
                        "assets/images/landscape/1- Tree trimming.jpeg"
                      ]),
                  ProductDto(
                      name: "Tree Removal",
                      seName: "tree-removal-service",
                      pictures: [
                        "assets/images/landscape/2-  Tree removal.jpeg"
                      ])
                ],
                description:
                    " <p>It typically relates to removal from landscape crops of overgrown branches of trees. Such surplus growth can prevent enough sunlight from the remainder of the tree, which implies this method can help enhance general health.</p>\r\n\r\n<p>This method can also be used to preserve a shrub or tree shape. This tree removal service generally is performed when required, generally in the dormant season. Shears on trees and hedge trimmers on shrubbery are generally used by professionals. Every tree is either an asset or a liability. When a professional tree risk assessment?uncovers a potential issue &ndash; perhaps the tree is damaged or diseased beyond repair or hindrance in constriction &ndash; tree removal or tree cutting may be required. Bluebell experts can work with you to safely and efficiently remove your tree. Many tree removals are complex, and mistakes are costly &ndash; make sure the professional you choose is qualified.</p>\r\n ",
                title: "Tree Trimming & Removal",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005516_tree-trimming-removal.jpg",
                seName: "tree-trimming-and-removal"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Sodding",
                      seName: "sodding-service",
                      pictures: ["assets/images/landscape/1-sodding.jpg"]),
                  ProductDto(
                      name: "Seeding",
                      seName: "seeding-service",
                      pictures: ["assets/images/landscape/2-Top dressing.jpg"]),
                  ProductDto(
                      name: "Top Dressing",
                      seName: "top-dressing-service",
                      pictures: ["assets/images/landscape/3-Grading.jpg"]),
                  ProductDto(
                      name: "Garden Dethatching",
                      seName: "garden-dethatching-service",
                      pictures: ["assets/images/landscape/4-Seeding.jpg"]),
                  ProductDto(
                      name: "Grading",
                      seName: "grading-service",
                      pictures: [
                        "assets/images/landscape/5 garden detaching.jpg"
                      ]),
                ],
                description:
                    "  <p>Sodding is the best way to instantly have one of the best lawns on the block. Sodding is more expensive than seeding but comes with some obvious advantages. The first advantage is not waiting; your garden is instantly green. Compared to seeding, sodding is more family friend in the sense that family can generally start using a sodded garden within a week or two of installation. A seeded lawn can take about 12 weeks to come in. </p>  ",
                title:
                    "Sodding, Seeding, Top Dressing, Garden Dethatching, Grading",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005504_sodding-seeding-top-dressing-garden-dethatching-grading.jpg",
                seName:
                    "sodding-seeding-top-dressing-garden-dethatching-grading"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Perennial Planting",
                      seName: "perennial-planting-service",
                      pictures: [
                        "assets/images/landscape/1-Pernial planting.jpg"
                      ]),
                  ProductDto(
                      name: "Annual Planting",
                      seName: "annual-planting-service",
                      pictures: [
                        "assets/images/landscape/2-annual planting.jpg"
                      ]),
                  ProductDto(
                      name: "Shrub Planting",
                      seName: "shrub-planting-service",
                      pictures: [
                        "assets/images/landscape/3-shrub-planting.jpg"
                      ]),
                  ProductDto(
                      name: "Tree Planting",
                      seName: "tree-planting-service",
                      pictures: [
                        "assets/images/landscape/4-Tree planting.jpg"
                      ]),
                ],
                description:
                    " <p>A few of our favorite perennials; the following list outlines some of our favorite perennials for different conditions:</p>\r\n\r\n<strong>Full Shade Perennials</strong>\r\n\r\n<p>Astilbe, Monkshood, Siberian Bugloss, Bugbane, Bleeding Heart, Hellebore, Coral Bells, Hosta, Gooseneck loosestrife, Lungwort, Christmas Rose.</p>\r\n\r\n<strong>Full Sun Perennials</strong>\r\n\r\n<p>Yarrow, Hollyhock, Marguerite Daisy, Rock Cress, Thrift, Aster, Cornflower, Delphinium, Pinks, Gas plant, Globe Thistle, Foxtail Lily, Blanket Flower, False Sunflower, Lavender, Gayfeather, Flax, Evening Primrose, Peony, Poppy, Black-Eyed Susan, Perennial Sage, Sedum.</p>\r\n\r\n<strong>Perennials for Clay Soil</strong>\r\n\r\n<p>Goatsbeard, Astilbe, Bergenia, Marsh Marigold, Turtlehead, Bugbane, Bleeding heart, Joe-Pye Weed, Meadowsweet, Rose Mallow, Japanese Iris, Blazing Star, Ligularia, Cardinal Flower, Beebalm, Balloon flower, Jacob&rsquo;s Ladder, Coneflower, White trillium, Globeflower.</p>\r\n\r\n<strong>Drought Tolerant Plants</strong>\r\n\r\n<p>Yarrow, Columbines, Artemisia, Butterfly weed, Aster, Coreopsis, Purple Cone Flower, Blanket Flower, Baby&rsquo;s-breath, Daylilies, Gayfeather, Beebalm, Obedient Plant, Sedums, Hens and Chicks, Lamb&rsquo;s-ear, Creeping Thyme.</p>     ",
                title: "Perennial, Annual, Shrub & Tree Planting",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005509_perennial-annual-shrub-tree-planting.jpg",
                seName: "perennial-annual-shrub-and-tree-planting"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Installation of Compost",
                      seName: "installation-of-compost",
                      pictures: [
                        "assets/images/landscape/1-instalation-of-compost.jpg"
                      ]),
                  ProductDto(
                      name: "Installation of Mulch",
                      seName: "installation-of-mulch-service",
                      pictures: ["assets/images/landscape/2-mulch.jpg"]),
                  ProductDto(
                      name: "Installation of Triple Mix",
                      seName: "installation-of-triple-mix-service",
                      pictures: ["assets/images/landscape/3-triple-mix.jpg"]),
                  ProductDto(
                      name: "Installation of Loam",
                      seName: "installation-of-loam-service",
                      pictures: [
                        "assets/images/landscape/4-flagstone-walkways.jpg"
                      ]),
                  ProductDto(
                      name: "Installation of Riverrock",
                      seName: "installation-of-riverrock-service",
                      pictures: [
                        "assets/images/landscape/5-dry-laid-retaining-wall.jpg"
                      ]),
                  ProductDto(
                      name: "Installation of Pea Gravel",
                      seName: "installation-of-pea-gravel-service",
                      pictures: [
                        "assets/images/landscape/6-installation-of-loam.jpg"
                      ]),
                  ProductDto(
                      name: "Installation of Flagstone Walkways",
                      seName: "installation-of-flagstone-walkways-service",
                      pictures: ["assets/images/landscape/7-reverrock.jpg"]),
                  ProductDto(
                      name: "Installation of Dry Laid Retaining Walls",
                      seName:
                          "installation-of-dry-laid-retaining-walls-service",
                      pictures: [
                        "assets/images/landscape/8-installation-of-peagravel.jpg"
                      ]),
                ],
                description:
                    "Installation of Compost, Mulch, Triple Mix, Loam, River Rock, Pea Gravel, Flagstone Walkways, Dry Laid Retaining Walls, Dry Wells.",
                title: "Installation Services",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005517_installation-services.jpg",
                seName: "installation-services"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Custom Urns",
                      seName: "custom-urns-service",
                      pictures: [
                        "assets/images/landscape/1-custom-urns-opt.jpeg"
                      ]),
                  ProductDto(
                      name: "Custom Planters",
                      seName: "custom-planters-service",
                      pictures: ["assets/images/landscape/2-planters.jpeg"])
                ],
                description:
                    "<p>At bluebell we know what works and what doesn&rsquo;t and we have the relevant knowledge and experience to deliver. We give customers the flexibility to order whatever they want and only what they need. Our ranges include contemporary, rustic and traditional styles from value lines to high end items.<br />\r\n&nbsp;<br />\r\nIn addition to planters we also offer a range of landscape features. This range includes walls, burners and water features crafted locally from materials including corten steel, aluminium and fibreglass. We&rsquo;re also able to offer a bespoke service with this range so if you can&#39;t quite find what you&#39;re after send us your ideas!<br />\r\n&nbsp;<br />\r\nWhether you require one planter for a landscape project or several, we offer a first class service.</p>\r\n",
                title: "Custom Urns & Planters for Every Season & /Or Occasion",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005508_custom-urns-and-planters-for-every-season-and-or-occasion.jpg",
                seName:
                    "custom-urns-and-planters-for-every-season-or-occasion"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Fertilizing Control",
                      seName: "fertilizing-control-service",
                      pictures: [
                        "assets/images/landscape/1-veggie-fertilizer.jpg"
                      ]),
                  ProductDto(
                      name: "Weeds Control",
                      seName: "weeds-control-service",
                      pictures: ["assets/images/landscape/2-weed-control.jpg"]),
                ],
                description:
                    "  <p>Gardens can thin out due to a number of reasons, but almost always the #1 culprit is a lack of nutrients. Grass requires fertilization to become dense enough to out-compete other lawn weeds like dandelions and clovers. Properly fertilizing your garden begins the process of strengthening and thickening your garden, which will start choking out some of the weeds on its own.</p>\r\n\r\n<p>Weeds must be removed to establish high-quality turf. A weed-free garden is very important, especially when over-seeding to increase turf quality because killing the weeds prior to overseeding will provide voids in the lawn once taken up by the weeds, where new seedlings can begin to establish and fill in. We make weed control very easy and effective with proper and timely applications of weed control products.</p>  ",
                title: "Organic Garden Fertilizing & Weeds Control",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005507_organic-garden-fertilizing-weeds-control.jpg",
                seName: "organic-garden-fertilizing-and-weeds-control"),
            CategoryCompactDto(
                products: [
                  ProductDto(
                      name: "Garden Consultation",
                      seName: "garden-consultation-service",
                      pictures: [
                        "assets/images/landscape/15-Garden Consultation.jpeg"
                      ]),
                ],
                description:
                    "      <p>Do you have any questions about your garden? Are you feeling overwhelmed and need a plan? Confused about where/how to start your garden? How to solve specific problems? Too many pest and disease issues? Want to design your space more efficiently? Set up a compost or worm farm? Not sure what plants to sow and when in our local climate? Need help with a garden project? Please consult our experts to find the solutions.</p>       ",
                title: "Garden Consultation",
                bannerUrl:
                    "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005622_0005441-services-1000x1000-1-.jpeg",
                seName: "garden-consultation"),
            CategoryCompactDto(
              products: [
                ProductDto(
                    name: "Brush Fill",
                    seName: "brush-fill-service",
                    pictures: [
                      "assets/images/landscape/1-services-brush-cleaning.jpg"
                    ]),
                ProductDto(
                    name: "Clean Fill",
                    seName: "clean-fill-service",
                    pictures: ["assets/images/landscape/2-cleanfill.jpg"]),
              ],
              description:
                  "<p>There are many ways to dispose of your garden waste including bluebell garden site waste cleaning and collection service. All grass and leaves should be collected in plastic bags and tied securely. Large branches which cannot be placed inside the plastic bag should be tied up in small bundles. Our team will do it all for you efficiently.<p>",
              title: "Disposal Services (Brush & Clean Fill)",
              bannerUrl:
                  "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005506_disposal-services-brush-clean-fill-.jpg",
            ),
          ],
          title: "All Services",
          bannerUrl:
              "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005648_all-services-banner.jpeg",
          seName: "all-landscape-services");

  factory CategoryCompactDto.fromJson(String str) {
    return CategoryCompactDto.fromMap(json.decode(str));
  }
  static List<CategoryCompactDto> fromMapList(Iterable<dynamic> json) {
    return List<CategoryCompactDto>.from(
        json.map((x) => CategoryCompactDto.fromMap(x)));
  }
  //String toJson() => json.encode(toMap());

  CategoryCompactDto.fromMap(Map<String, dynamic> json) {
    description = json["description"] == null ? null : json["description"];
    templateTypeName =
        json["templateTypeName"] == null ? null : json["templateTypeName"];
    title = json["title"];
    bannerUrl = json["bannerUrl"];
    seName = json["seName"];
    products = json['products'] == null
        ? List<ProductDto>()
        : ProductDto.fromMapList(json['products']);
    subCategories = json['subCategories'] == null
        ? List<CategoryCompactDto>()
        : CategoryCompactDto.fromMapList(json['subCategories']);
  }

  setProductsImagesPath() async {
    if (products != null) {
      for (var category in subCategories) {
        for (var product in category.products) {
          product.pictureThumb =
              await LocalImageService.getLocalImagePath(product.pictureThumb) ??
                  product.pictureThumb;
        }
      }
    }
  }
}
