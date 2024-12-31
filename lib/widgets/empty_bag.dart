import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyBag extends StatelessWidget {
  const EmptyBag({
    super.key,
    required this.mainImage,
    required this.mainTitle,
    required this.subTitle,
    required this.buttonText,
    required this.buttonFunction,
    this.backButton = const SizedBox.shrink(),
  });

  final Widget mainImage;
  final String mainTitle;
  final String subTitle;
  final String buttonText;
  final void Function() buttonFunction;
  final Widget backButton;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: mainImage,
            ),
            Text(
              mainTitle,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  fontSize: 17,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: buttonFunction,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.2,
                  vertical: 20,
                ),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            backButton,
          ],
        ),
      ),
    );
  }
}
