import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_ar/providers/cart_provider.dart';
import 'package:shopsmart_users_ar/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users_ar/services/assets_manager.dart';
import 'package:shopsmart_users_ar/widgets/empty_bag.dart';
import 'package:shopsmart_users_ar/widgets/title_text.dart';

import '../../providers/product_provider.dart';
import 'cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
   // final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
                imagePath: AssetsManager.shoppingBasket,
                title: "Your cart is empty",
                subtitle:
                    "Looks like you didn't add anything yet to your cart \ngo ahead and start shopping now",
                buttonText: "Shop now"),
          )
        : Scaffold(
            bottomSheet: const CartBottomCheckout(),
            appBar: AppBar(
              title: TitlesTextWidget(label: "Cart (${cartProvider.getCartItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return const CartWidget();
              },
            ),
          );
  }
}
