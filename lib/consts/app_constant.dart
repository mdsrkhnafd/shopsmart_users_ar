import 'package:shopsmart_users_ar/services/assets_manager.dart';

import '../models/categories_model.dart';

class AppConstants {
  static const String imageUrl =
      "https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png";

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "Air Conditioners",
      image: AssetsManager.aircondition,
      name: "Air Conditioners",
    ),
    CategoryModel(
      id: "Home Decoration",
      image: AssetsManager.homedecoration,
      name: "Home Decoration",
    ),
    CategoryModel(
      id: "Jewellery",
      image: AssetsManager.jewelerry,
      name: "Jewellery",
    ),
    CategoryModel(
      id: "Refrigerators",
      image: AssetsManager.refrigerator,
      name: "Refrigerators",
    ),
    CategoryModel(
      id: "Snack Foods",
      image: AssetsManager.snakefoods,
      name: "Snack Foods",
    ),
    CategoryModel(
      id: "Sunglasses",
      image: AssetsManager.sunglasess,
      name: "Sunglasses",
    ),
    CategoryModel(
      id: "Televisions",
      image: AssetsManager.televisions,
      name: "Televisions",
    ),
    // CategoryModel(
    //   id: "Cosmetics",
    //   image: AssetsManager.cosmetics,
    //   name: "Cosmetics",
    // ),
  ];
}
