import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin_app/constants/app_colors.dart';
import 'package:ecom_admin_app/model/category.dart';
import 'package:ecom_admin_app/model/product.dart';
import 'package:ecom_admin_app/providers/theme_provider.dart';
import 'package:ecom_admin_app/services/app_functions.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:ecom_admin_app/widgets/app_title.dart';
import 'package:ecom_admin_app/widgets/form_fields.dart';
import 'package:ecom_admin_app/widgets/product_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class AddUpdateProductScreen extends ConsumerStatefulWidget {
  const AddUpdateProductScreen({
    super.key,
    this.product,
  });

  final Product? product;

  @override
  ConsumerState<AddUpdateProductScreen> createState() =>
      _AddUpdateProductScreenState();
}

class _AddUpdateProductScreenState
    extends ConsumerState<AddUpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _productTitle;
  String? _price;
  String? _qty;
  String? _description;
  Category? _category;
  File? pickedImage;
  bool isLoading = false;

  void _uploadProduct(bool isDarkmodeOn) async {
    if (!_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    }

    if (pickedImage == null) {
      AppFunctions.showErrorOrWarningOrImagePickerDialog(
        context: context,
        isWarning: false,
        mainTitle: "Please select a product image!",
        icon: Icon(IconManager.imagepickingErrorIcon),
        action1Text: "OK",
        action2Text: "",
        action1Func: () async {
          Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
        },
        action2Func: () {},
        isDarkmodeOn: isDarkmodeOn,
      );
      return;
    }

    _formKey.currentState!.save();

    if (_productTitle == null ||
        _qty == null ||
        _price == null ||
        _description == null ||
        _category == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final uid = const Uuid().v4();

    final ref =
        FirebaseStorage.instance.ref().child("productsImage").child("$uid.jpg");

    await ref.putFile(pickedImage!);

    String imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection("products").doc(uid).set({
      "productId": uid,
      "productTitle": _productTitle,
      "productPrice": _price,
      "productCategory": _category!.name,
      "productDescription": _description,
      "productImage": imageUrl,
      "productQuantity": _qty,
      "createdAt": Timestamp.now(),
    });

    await Fluttertoast.showToast(
      msg: "Your product is added!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isDarkmodeOn
          ? AppColors.lightScaffoldColor
          : AppColors.darkScaffoldColor,
      textColor: isDarkmodeOn
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      fontSize: 16.0,
    );

    if (!mounted) return;
    Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;

    setState(() {
      isLoading = false;
    });
  }

  void _updateProduct(bool isDarkmodeOn) {
    AppFunctions.showErrorOrWarningOrImagePickerDialog(
      context: context,
      isWarning: true,
      mainTitle: "Do you want to update this product?",
      icon: Icon(IconManager.addNewProduct),
      action1Text: "No",
      action2Text: "Yes",
      action1Func: () {
        Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
      },
      action2Func: () {
        Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;

        Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
      },
      isDarkmodeOn: isDarkmodeOn,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkmodeOn = ref.watch(darkModeThemeStatusProvider);

    if (widget.product != null) {
      _productTitle = widget.product!.productTitle;
      _price = widget.product!.productPrice;
      _qty = widget.product!.productQuantity;
      _description = widget.product!.productDescription;
      _category = Category.CATEGORIES.firstWhere(
        (item) => item.name == widget.product!.productCategory,
      );
    }

    final OutlineInputBorder outlinedInputBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
      borderSide: BorderSide(
        width: 1.5,
        color: isDarkmodeOn ? Colors.white : Colors.black,
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: isLoading
            ? null
            : AppBar(
                title: Text(widget.product == null
                    ? "Add New Product"
                    : "Update Product"),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.canPop(context)
                          ? Navigator.of(context).pop()
                          : null;
                    },
                    icon: Icon(
                      IconManager.backButtonIcon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
        body: isLoading
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppTitle(
                      fontSize: 30.0,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Submitting your product, Please wait...",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oxygen(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ProductImagePicker(
                              borderColor:
                                  isDarkmodeOn ? Colors.white : Colors.black,
                              productImageUrl: widget.product?.productImage,
                              pickedImageFileGetter: (File? file) {
                                pickedImage = file;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: DropdownButtonFormField<Category>(
                                decoration: InputDecoration(
                                  enabledBorder: outlinedInputBorder,
                                  focusedBorder: outlinedInputBorder,
                                  errorBorder: outlinedInputBorder,
                                  focusedErrorBorder: outlinedInputBorder,
                                  label: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                    ),
                                    child: Text(
                                      "Product Category",
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  alignLabelWithHint: true,
                                ),
                                hint: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "Select Product Category",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                items: Category.CATEGORIES
                                    .map(
                                      (category) => DropdownMenuItem<Category>(
                                        value: category,
                                        child: Text(category.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  _category = value;
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a category';
                                  }
                                  return null;
                                },
                                value: _category,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: CustomFormField(
                                outlinedInputBorder: outlinedInputBorder,
                                inputLabel: "Product Title",
                                nullValueErrorStringValidator:
                                    "Please enter a valid Title!",
                                validatorErrorString:
                                    "Please enter a valid Title!",
                                onSavedFunction: (value) {
                                  _productTitle = value;
                                },
                                formFieldType: FormFieldType.name,
                                maxLen: 80,
                                keyboardType: TextInputType.text,
                                initialValue: _productTitle,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25.0,
                                    right: 12,
                                  ),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            40,
                                    child: CustomFormField(
                                      outlinedInputBorder: outlinedInputBorder,
                                      inputLabel: "Price",
                                      nullValueErrorStringValidator:
                                          "Please enter a valid Price!",
                                      validatorErrorString:
                                          "Please enter a valid Price!",
                                      onSavedFunction: (value) {
                                        _price = value;
                                      },
                                      formFieldType: FormFieldType.price,
                                      keyboardType: TextInputType.number,
                                      initialValue:
                                          _price != null ? "$_price" : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 25.0,
                                    left: 12,
                                  ),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            40,
                                    child: CustomFormField(
                                      outlinedInputBorder: outlinedInputBorder,
                                      inputLabel: "Qty",
                                      nullValueErrorStringValidator:
                                          "Please enter a valid Quantity!",
                                      validatorErrorString:
                                          "Please enter a valid Quantity!",
                                      onSavedFunction: (value) {
                                        _qty = value;
                                      },
                                      formFieldType: FormFieldType.qty,
                                      keyboardType: TextInputType.number,
                                      initialValue: _qty,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: TextFormField(
                                maxLength: 1000,
                                decoration: InputDecoration(
                                  enabledBorder: outlinedInputBorder,
                                  focusedBorder: outlinedInputBorder,
                                  errorBorder: outlinedInputBorder,
                                  focusedErrorBorder: outlinedInputBorder,
                                  label: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                    ),
                                    child: Text(
                                      "Product Description",
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  alignLabelWithHint: true,
                                ),
                                minLines: 2,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a description';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _description = value;
                                },
                                initialValue: _description,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 60,
                              child: ElevatedButton(
                                onPressed: widget.product == null
                                    ? () {
                                        _uploadProduct(isDarkmodeOn);
                                      }
                                    : () {
                                        _updateProduct(isDarkmodeOn);
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                ),
                                child: widget.product == null
                                    ? Text(
                                        "Submit Product",
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : Text(
                                        "Update Product",
                                        style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
