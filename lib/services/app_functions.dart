import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecom_admin_app/model/product.dart';
import 'package:ecom_admin_app/providers/cart_provider.dart';
import 'package:ecom_admin_app/providers/wishlist_provider.dart';

class AppFunctions {
  static Future<void> showErrorOrWarningOrImagePickerDialog(
      {required BuildContext context,
      required bool isWarning,
      required String mainTitle,
      required Icon icon,
      required String action1Text,
      required String action2Text,
      required Function action1Func,
      required Function action2Func,
      required bool isDarkmodeOn}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: icon,
          title: Text(
            mainTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(
              color: isDarkmodeOn ? Colors.white : Colors.black,
              fontSize: 18,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      action1Func();
                    },
                    child: Text(
                      action1Text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Visibility(
                  visible: isWarning,
                  child: const SizedBox(
                    width: 16,
                  ),
                ),
                Visibility(
                  visible: isWarning,
                  child: Flexible(
                    child: TextButton(
                      onPressed: () {
                        action2Func();
                      },
                      child: Text(
                        action2Text,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static void showListRelatedSnackBar(
    BuildContext context,
    Product product,
    WidgetRef ref,
    bool isAlreayExists,
    String alreayExistMessage,
    String successfullyAddedMessage,
    String type,
  ) {
    if (isAlreayExists) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              alreayExistMessage,
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            duration: const Duration(milliseconds: 1500),
          ),
        );
    } else {
      if (type == "cart") {
        ref.read(cartProvider.notifier).createNewCartItem(product);
      } else if (type == "wishlist") {
        ref.read(wishListProvider.notifier).addToWishList(product);
      } else if (type == "recently_viewd") {
      } else if (type == "cartRemoval") {
        ref.read(cartProvider.notifier).deleteFromCart(product);
      }

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            successfullyAddedMessage,
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
        ));
    }
  }
}
