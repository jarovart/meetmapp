import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:casttime/app/model/enums/appdesign.dart';

class ThemeDesign {
  static ThemeData getPreviewThemeByAppDesign(
    AppDesign design,
    Brightness platformBrightness,
  ) {
    if (design == AppDesign.system) {
      return platformBrightness == Brightness.dark
          ? mapDarkTheme(AppDesign.darkWhite)
          : mapLightTheme(AppDesign.lightRose);
    }

    return getThemeByAppDesign(design);
  }

  static ThemeData getThemeByAppDesign(AppDesign design) {
    return switch (design) {
      AppDesign.lightBlack => mapLightTheme(design),
      AppDesign.lightRose => mapLightTheme(design),
      AppDesign.lightWine => mapLightTheme(design),
      AppDesign.darkWhite => mapDarkTheme(design),
      AppDesign.darkGold => mapDarkTheme(design),
      AppDesign.darkPink => mapDarkTheme(design),
      _ => mapLightTheme(design),
    };
  }

  static ThemeMode getThemeModeByAppDesign(AppDesign design) {
    return switch (design) {
      AppDesign.lightBlack ||
      AppDesign.lightRose ||
      AppDesign.lightWine => ThemeMode.light,

      AppDesign.darkWhite ||
      AppDesign.darkGold ||
      AppDesign.darkPink => ThemeMode.dark,

      _ => ThemeMode.system,
    };
  }

  static ThemeData mapDarkTheme(AppDesign design) {
    final accent = switch (design) {
      AppDesign.darkGold => const Color(0xFFFFAF37),
      AppDesign.darkPink => const Color(0xFFFF4FD8),
      _ => const Color.fromARGB(255, 207, 207, 207),
    };
    final secondaryAccent = switch (design) {
      AppDesign.darkGold => const Color(0xFFFFAF37),
      AppDesign.darkPink => const Color.fromARGB(255, 250, 128, 223),
      _ => const Color.fromARGB(255, 167, 167, 167),
    };

    final backGroundAccent = switch (design) {
      _ => const Color(0xFF202020),
    };

    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 8,
        shadowColor: backGroundAccent.withValues(alpha: 0.35),
        surfaceTintColor: Colors.transparent,
        backgroundColor: backGroundAccent,
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
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: accent,
            brightness: Brightness.dark,
          ).copyWith(
            primary: accent,
            primaryContainer: accent.withValues(alpha: 0.25),
            secondary: secondaryAccent,
            secondaryContainer: secondaryAccent.withValues(alpha: 0.25),
            onSurface: accent,
            onPrimary: Colors.black,
            onSecondary: Colors.black,
          ),
      listTileTheme: ListTileThemeData(
        textColor: accent,
        iconColor: accent,
        titleTextStyle: TextStyle(
          color: accent,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: TextStyle(color: secondaryAccent, fontSize: 14),
      ),
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: accent,
        displayColor: accent,
      ),
      iconTheme: IconThemeData(color: accent),

      //background of all pages
      scaffoldBackgroundColor: const Color(0xFF101010),
      //infocard background
      cardTheme: CardThemeData(color: backGroundAccent),
    );
  }

  static ThemeData mapLightTheme(AppDesign design) {
    final accent = switch (design) {
      AppDesign.lightWine => const Color.fromARGB(255, 100, 0, 25),
      AppDesign.lightRose => const Color(0xFFFF4FD8),
      _ => const Color.fromARGB(255, 63, 63, 63),
    };
    final secondaryAccent = switch (design) {
      AppDesign.lightWine => const Color(0xFF800020),
      AppDesign.lightRose => const Color(0xFFFA80DF),
      _ => const Color.fromARGB(255, 0, 0, 0),
    };

    final backGroundAccent = switch (design) {
      _ => Color.fromARGB(255, 255, 255, 255),
    };

    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 8,
        shadowColor: backGroundAccent.withValues(alpha: 0.35),
        surfaceTintColor: const Color.fromARGB(0, 255, 255, 255),
        backgroundColor: backGroundAccent,
        foregroundColor: accent,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: accent,
        unselectedLabelColor: secondaryAccent,
        indicatorColor: accent,
        dividerColor: const Color.fromARGB(0, 255, 255, 255),
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
      brightness: Brightness.light,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: accent,
            brightness: Brightness.light,
          ).copyWith(
            primary: accent,
            primaryContainer: accent.withValues(alpha: 0.25),
            secondary: secondaryAccent,
            secondaryContainer: secondaryAccent.withValues(alpha: 0.25),
            onSurface: accent,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
          ),
      listTileTheme: ListTileThemeData(
        textColor: accent,
        iconColor: accent,
        titleTextStyle: TextStyle(
          color: accent,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: TextStyle(color: secondaryAccent, fontSize: 14),
      ),
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: accent,
        displayColor: accent,
      ),
      iconTheme: IconThemeData(color: accent),
      scaffoldBackgroundColor: Color(0xFFFEF7FF),
      cardTheme: CardThemeData(color: backGroundAccent),
    );
  }
}
