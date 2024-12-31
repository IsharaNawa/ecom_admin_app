import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import 'package:ecom_admin_app/providers/theme_provider.dart';

class AppTitle extends ConsumerWidget {
  const AppTitle({super.key, required double fontSize}) : _fontSize = fontSize;

  final double _fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkmodeOn = ref.watch(darkModeThemeStatusProvider);
    return Shimmer.fromColors(
      period: const Duration(seconds: 10),
      baseColor: isDarkmodeOn ? Colors.white : Colors.black,
      highlightColor: isDarkmodeOn ? Colors.black45 : Colors.white,
      child: Text(
        "DealVerse",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
