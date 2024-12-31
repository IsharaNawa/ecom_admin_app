import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem(
      {super.key,
      required this.name,
      required this.btnIcon,
      required this.onPressedFunc});

  final String name;
  final IconData btnIcon;
  final void Function() onPressedFunc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onPressedFunc();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          shadowColor: Colors.grey,
          color: Theme.of(context).colorScheme.inversePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            height: 100,
            width: size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(btnIcon),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
