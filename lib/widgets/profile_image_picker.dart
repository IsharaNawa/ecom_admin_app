import 'package:ecom_admin_app/providers/theme_provider.dart';
import 'package:ecom_admin_app/services/app_functions.dart';
import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductImagePicker extends ConsumerStatefulWidget {
  const ProductImagePicker({super.key, required this.borderColor});

  final Color borderColor;

  @override
  ConsumerState<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends ConsumerState<ProductImagePicker> {
  File? pickedImage;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> getImage(ImageSource imageSource) async {
    XFile? pickedImageXFile = await imagePicker.pickImage(source: imageSource);

    if (pickedImageXFile == null) {
      return;
    }

    setState(() {
      pickedImage = File(pickedImageXFile.path);
    });
  }

  Future<void> triggerImagePickDialogBox(bool isDarkmodeOn) async {
    await AppFunctions.showErrorOrWarningOrImagePickerDialog(
      context: context,
      isWarning: true,
      mainTitle: "Select Your Image Source",
      icon: Icon(IconManager.showImagePickerDialogBoxIcon),
      action1Text: "Camera",
      action2Text: "Gallery",
      action1Func: () async {
        await getImage(ImageSource.camera);
        Navigator.of(context).pop();
      },
      action2Func: () async {
        await getImage(ImageSource.gallery);
        Navigator.of(context).pop();
      },
      isDarkmodeOn: isDarkmodeOn,
    );
  }

  Future<void> triggerImageDeletionConfirmationDialogBox(
      bool isDarkmodeOn) async {
    await AppFunctions.showErrorOrWarningOrImagePickerDialog(
      context: context,
      isWarning: true,
      mainTitle: "Do you want to delete the Image?",
      icon: Icon(IconManager.deletePickedImageIcon),
      action1Text: "No",
      action2Text: "Yes",
      action1Func: () async {
        Navigator.of(context).pop();
      },
      action2Func: () async {
        setState(() {
          pickedImage = null;
        });
        Navigator.of(context).pop();
      },
      isDarkmodeOn: isDarkmodeOn,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkmodeOn = ref.watch(darkModeThemeStatusProvider);

    Widget imageIconContent = InkWell(
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(
            IconManager.showImagePickerDialogBoxIcon,
          ),
        ),
      ),
      onTap: () {
        triggerImagePickDialogBox(isDarkmodeOn);
      },
    );

    if (pickedImage != null) {
      imageIconContent = InkWell(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              IconManager.deletePickedImageIcon,
            ),
          ),
        ),
        onTap: () {
          triggerImageDeletionConfirmationDialogBox(isDarkmodeOn);
        },
      );
    }

    return GestureDetector(
      onTap: () async {
        triggerImagePickDialogBox(isDarkmodeOn);
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.borderColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: pickedImage == null
                  ? FancyShimmerImage(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2018/11/13/22/01/instagram-3814084_640.png",
                      boxFit: BoxFit.cover,
                    )
                  : Image.file(
                      pickedImage!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: imageIconContent,
          ),
        ],
      ),
    );
  }
}
