import 'package:flutter/material.dart';
import 'package:shopsmart_users_ar/models/cart_model.dart';
import 'package:shopsmart_users_ar/models/viewed_products.dart';
import 'package:shopsmart_users_ar/models/wishlist_model.dart';
import 'package:shopsmart_users_ar/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

class ViewedRecentlyProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getViewedProd {
    return _viewedProdItems;
  }

  void addViewedProd({required String productId}) {

      _viewedProdItems.putIfAbsent(
        productId,
            () => ViewedProdModel(viewedProdId: Uuid().v4(), productId: productId)
      );

    notifyListeners();
  }

  void viewedProdLocalClear() {
    _viewedProdItems.clear();
    notifyListeners();
  }

}
