import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecom_admin_app/model/product.dart';
import 'package:ecom_admin_app/screens/inner_screens/product_details_screen.dart';

class ProductGridWidget extends ConsumerStatefulWidget {
  const ProductGridWidget({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends ConsumerState<ProductGridWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailsScreen(
                product: widget.product,
              );
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: FancyShimmerImage(
                imageUrl: widget.product.productImage,
                width: double.infinity,
                height: size.width * 0.43,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.product.productTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
            ),
            child: Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "\$${widget.product.productPrice}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
