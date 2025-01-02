import 'package:ecom_admin_app/constants/theme_data.dart';
import 'package:ecom_admin_app/providers/theme_provider.dart';
import 'package:ecom_admin_app/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkmodeOn = ref.watch(darkModeThemeStatusProvider);

    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              title: 'ECom Admin App[Firebase Loading]',
              theme:
                  Styles.themeData(isDarkTheme: isDarkmodeOn, context: context),
              home: const Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return MaterialApp(
              title: 'ECom Admin App[Firebase Error]',
              theme:
                  Styles.themeData(isDarkTheme: isDarkmodeOn, context: context),
              home: Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      Text(
                        snapshot.error.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return MaterialApp(
            title: 'ECom Admin App',
            theme:
                Styles.themeData(isDarkTheme: isDarkmodeOn, context: context),
            home: const DashboardScreen(),
          );
        });
  }
}
