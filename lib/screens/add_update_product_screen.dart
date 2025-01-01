import 'package:ecom_admin_app/model/category.dart';
import 'package:ecom_admin_app/model/product.dart';
import 'package:ecom_admin_app/providers/theme_provider.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:ecom_admin_app/widgets/form_fields.dart';
import 'package:ecom_admin_app/widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUpdateProductScreen extends ConsumerStatefulWidget {
  AddUpdateProductScreen({
    super.key,
    this.product,
  });

  Product? product;

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
        appBar: AppBar(
          title: Text(
              widget.product == null ? "Add New Product" : "Update Product"),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: IconButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.of(context).pop() : null;
              },
              icon: Icon(
                IconManager.backButtonIcon,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ProductImagePicker(
                        borderColor: isDarkmodeOn ? Colors.white : Colors.black,
                        productImageUrl: widget.product?.productImage,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: CustomFormField(
                          outlinedInputBorder: outlinedInputBorder,
                          inputLabel: "Product Title",
                          nullValueErrorStringValidator:
                              "Please enter a valid Title!",
                          validatorErrorString: "Please enter a valid Title!",
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
                              width: MediaQuery.of(context).size.width / 2 - 40,
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
                                initialValue: _price != null ? "$_price" : null,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 25.0,
                              left: 12,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 40,
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
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                                  if (!_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
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

                                  Navigator.of(context).canPop()
                                      ? Navigator.of(context).pop()
                                      : null;
                                }
                              : () {
                                  Navigator.of(context).canPop()
                                      ? Navigator.of(context).pop()
                                      : null;
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
