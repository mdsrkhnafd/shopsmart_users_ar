import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_ar/services/assets_manager.dart';
import 'package:shopsmart_users_ar/widgets/empty_bag.dart';
import 'package:shopsmart_users_ar/widgets/title_text.dart';

import '../../providers/viewed_recently_provider.dart';
import '../../services/my_app_method.dart';
import '../../widgets/products/product_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedRecentlyProvider>(context);
    return viewedProdProvider.getViewedProd.isEmpty
        ? Scaffold(
      body: EmptyBagWidget(
        imagePath: AssetsManager.shoppingBasket,
        title: "Your Viewed recently is empty",
        subtitle:
        'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
        buttonText: "Shop Now",
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: TitlesTextWidget(label: "Viewed recently (${viewedProdProvider.getViewedProd.length})"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyAppMethods.showErrorORWarningDialog(
                  isError: false,
                  context: context, subtitle: "Clear viewed?", fct: () {
                viewedProdProvider.viewedProdLocalClear();
              });
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: DynamicHeightGridView(
        itemCount: viewedProdProvider.getViewedProd.length,
        builder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductWidget(productId: viewedProdProvider.getViewedProd.values.toList()[index].productId),
          );
        }),
        crossAxisCount: 2,
      ),
    );
  }
}
