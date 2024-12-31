import 'package:ecom_admin_app/providers/theme_provider.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:ecom_admin_app/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewProductScreen extends ConsumerWidget {
  const AddNewProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkmodeOn = ref.watch(darkModeThemeStatusProvider);

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

    final _formKey = GlobalKey<FormState>();
    String? _productTitle;
    String? _price;
    String? _qty;
    String? _description;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: CustomFormField(
                outlinedInputBorder: outlinedInputBorder,
                inputLabel: "Product Title",
                nullValueErrorStringValidator: "Please enter a valid Title!",
                validatorErrorString: "Please enter a valid Title!",
                onSavedFunction: (value) {
                  _productTitle = value;
                },
                formFieldType: FormFieldType.name,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomFormField(
                      outlinedInputBorder: outlinedInputBorder,
                      inputLabel: "Price",
                      nullValueErrorStringValidator:
                          "Please enter a valid Price!",
                      validatorErrorString: "Please enter a valid Price!",
                      onSavedFunction: (value) {
                        _price = value;
                      },
                      formFieldType: FormFieldType.price,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomFormField(
                      outlinedInputBorder: outlinedInputBorder,
                      inputLabel: "Qty",
                      nullValueErrorStringValidator:
                          "Please enter a valid Quantity!",
                      validatorErrorString: "Please enter a valid Quantity!",
                      onSavedFunction: (value) {
                        _productTitle = value;
                      },
                      formFieldType: FormFieldType.qty,
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
              child: CustomFormField(
                outlinedInputBorder: outlinedInputBorder,
                inputLabel: "Product Description",
                nullValueErrorStringValidator: "Please enter a valid Quantity!",
                validatorErrorString: "Please enter a valid Quantity!",
                onSavedFunction: (value) {
                  _productTitle = value;
                },
                formFieldType: FormFieldType.qty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
