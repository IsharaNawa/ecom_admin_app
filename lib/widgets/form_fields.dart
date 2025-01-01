import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FormFieldType {
  name,
  qty,
  price,
  description,
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.outlinedInputBorder,
    required this.inputLabel,
    required this.nullValueErrorStringValidator,
    required this.validatorErrorString,
    required this.onSavedFunction,
    required this.formFieldType,
  });

  final OutlineInputBorder outlinedInputBorder;
  final String inputLabel;
  final String nullValueErrorStringValidator;
  final String validatorErrorString;
  final void Function(String value) onSavedFunction;
  final FormFieldType formFieldType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return nullValueErrorStringValidator;
        }

        if (formFieldType == FormFieldType.name) {
          if (value.length > 80) {
            return "Product title should be less than 80 characters";
          }
        } else if (formFieldType == FormFieldType.price) {
          if (double.tryParse(value) == null) {
            return "Please enter a numerical value";
          }
        } else if (formFieldType == FormFieldType.qty) {
          if (int.tryParse(value) == null) {
            return "Please enter a numerical value(without decimal points)";
          }
        } else if (formFieldType == FormFieldType.description) {
          if (value.length > 1000) {
            return "Product title should be less than 1000 characters";
          }
        }

        return null;
      },
      onSaved: (value) {
        onSavedFunction(value!);
      },
      autocorrect: false,
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
            inputLabel,
            style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
