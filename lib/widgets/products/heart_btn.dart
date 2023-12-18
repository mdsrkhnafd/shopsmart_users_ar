import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_ar/providers/wishlist_provider.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.size = 22,
    this.color = Colors.transparent,
    required this.productId,
    //  this.isInWishlist = false,
  });

  final double size;
  final Color color;
  final String productId;

  // final bool? isInWishlist;
  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishlistsProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
        ),
        onPressed: () async {
          // wishlistsProvider.addOrRemoveFromWishlist(
          //     productId: widget.productId);

          if (wishlistsProvider.getWishlist.containsKey(widget.productId)) {
           await wishlistsProvider.removeWishlistItemFromFirestore(
              wishlistId:
                  wishlistsProvider.getWishlist[widget.productId]!.wishlistId,
              productId: widget.productId,
            );
          } else {
           await wishlistsProvider.addToWishlistFirebase(
              productId: widget.productId,
              context: context,
            );
           await wishlistsProvider.fetchWishlist();
          }
        },
        icon: Icon(
          wishlistsProvider.isProdinWishlist(
            productId: widget.productId,
          )
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color: wishlistsProvider.isProdinWishlist(
            productId: widget.productId,
          )
              ? Colors.red
              : Colors.grey,
        ),
      ),
    );
  }
}
