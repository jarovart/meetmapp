import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/enums/appdesign.dart';

class ThemeDesign {
  static ThemeData mapDarkTheme(AppDesign design) {
    final accent = switch (design) {
      AppDesign.darkGold => const Color(0xFFFFAF37),
      AppDesign.darkPink => const Color(0xFFFF4FD8),
      _ => const Color(0xFF797979),
    };
    final secondaryAccent = switch (design) {
      AppDesign.darkGold => const Color(0xFFFFAF37),
      AppDesign.darkPink => const Color.fromARGB(255, 250, 128, 223),
      _ => const Color(0xFF797979),
    };

    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.35),
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFF101010),
        foregroundColor: accent,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: accent,
        unselectedLabelColor: secondaryAccent,
        indicatorColor: accent,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: secondaryAccent),
        floatingLabelStyle: TextStyle(color: secondaryAccent),

        /*enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: secondaryAccent.withValues(alpha: 0.35),
          ),
        ),*/
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accent, width: 2),
        ),
      ),
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF101010),
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: accent,
            brightness: Brightness.dark,
          ).copyWith(
            primary: accent,
            primaryContainer: accent.withValues(alpha: 0.25),
            secondary: secondaryAccent,
            secondaryContainer: secondaryAccent.withValues(alpha: 0.25),
          ),
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: accent,
        displayColor: accent,
      ),
      iconTheme: IconThemeData(color: accent),

      cardTheme: const CardThemeData(color: Color(0xFF1C1C1C)),
    );
  }

  static ThemeData mapLightTheme(AppDesign design) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFF1F5),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.pink,
        brightness: Brightness.light,
      ),
      cardTheme: const CardThemeData(color: Colors.white),
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
  }
}
