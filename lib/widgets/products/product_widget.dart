import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_ar/screens/inner_screens/product_details.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/viewed_recently_provider.dart';
import '../../services/my_app_method.dart';
import '../subtitle_text.dart';
import '../title_text.dart';
import 'heart_btn.dart';

class ProductWidget extends StatefulWidget {
  final String productId;

  const ProductWidget({
    super.key,
    required this.productId,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProdProvider = Provider.of<ViewedRecentlyProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: () async {
                viewedProdProvider.addViewedProd(
                    productId: getCurrProduct.productId);
                await Navigator.pushNamed(
                    context, ProductDetailsScreen.routName,
                    arguments: getCurrProduct.productId);
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FancyShimmerImage(
                          imageUrl: getCurrProduct.productImage,
                          height: size.height * 0.22,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            '(${getCurrProduct.productRatings ?? '4.3'})',
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TitlesTextWidget(
                            label: getCurrProduct.productTitle,
                            fontSize: 18,
                            maxLines: 2,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: HeartButtonWidget(
                            productId: getCurrProduct.productId,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SubtitleTextWidget(
                            label: "${getCurrProduct.productPrice}\$",
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        Flexible(
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.lightBlue,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () async {
                                if (cartProvider.isProdinCart(productId: getCurrProduct.productId)) {
                                  return;
                                }
                                try {
                                  cartProvider.addToCartFirebase(
                                    productId: getCurrProduct.productId,
                                    qty: 1,
                                    context: context,
                                  );
                                } catch (e) {
                                  await MyAppMethods.showErrorORWarningDialog(
                                    context: context,
                                    subtitle: e.toString(),
                                    fct: () {},
                                  );
                                }
                              },
                              splashColor: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  cartProvider.isProdinCart(productId: getCurrProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          );
  }
}
