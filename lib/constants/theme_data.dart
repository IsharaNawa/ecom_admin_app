import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecom_admin_app/constants/app_colors.dart';

class Styles {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return isDarkTheme
        ? ThemeData.dark().copyWith(
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Colors.black,
              elevation: 0,
            ),
            textTheme: GoogleFonts.ubuntuTextTheme().copyWith(
              titleSmall: GoogleFonts.ubuntu(
                color: Colors.white,
              ),
              bodyMedium: GoogleFonts.ubuntu(
                color: Colors.white,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40), // Rounded corners
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    30,
                  ),
                ),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    30,
                  ),
                ),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          )
        : ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.greenAccent,
            ),
            scaffoldBackgroundColor: AppColors.lightScaffoldColor,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.lightScaffoldColor,
              elevation: 0,
            ),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: AppColors.lightScaffoldColor,
              elevation: 0,
            ),
            textTheme: GoogleFonts.ubuntuTextTheme().copyWith(
              titleSmall: GoogleFonts.ubuntu(
                color: Colors.black,
              ),
              bodyMedium: GoogleFonts.ubuntu(
                color: Colors.black,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              // Error text color
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    30,
                  ),
                ),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    30,
                  ),
                ),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          );
  }
}
