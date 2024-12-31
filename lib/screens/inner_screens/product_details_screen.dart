import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecom_admin_app/model/product.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:ecom_admin_app/widgets/app_title.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.of(context).pop() : null;
          },
          icon: Icon(
            IconManager.backButtonIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: const AppTitle(
          fontSize: 24.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FancyShimmerImage(
                imageUrl: product.productImage,
                height: 300,
                width: double.infinity,
                boxFit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                product.productTitle,
                style: GoogleFonts.inter(
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                "\$${product.productPrice}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    product.productCategory,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                product.productDescription,
                style: GoogleFonts.lato(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
