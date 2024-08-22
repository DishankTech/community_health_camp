import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
      fontFamily: Montserrat,
      primaryColor: kPrimaryColor,
      colorScheme: _shrineColorScheme,
      scaffoldBackgroundColor: kScaffoldColor,
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: Montserrat),
          displayLarge: TextStyle(fontFamily: Montserrat),
          displayMedium: TextStyle(fontFamily: Montserrat),
          displaySmall: TextStyle(fontFamily: Montserrat)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark, // For Android (dark icons)
          statusBarIconBrightness: Brightness.dark, // For iOS (dark icons)
          // // Status bar color
          // statusBarColor: Colors.white,
          // // Status bar brightness (optional)
          // statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          // statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ));

  static final darkTheme = ThemeData(
      primaryColor: kPrimaryColor,
      colorScheme: _shrineColorScheme,
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: Montserrat),
          displayLarge: TextStyle(fontFamily: Montserrat),
          displayMedium: TextStyle(fontFamily: Montserrat),
          displaySmall: TextStyle(fontFamily: Montserrat)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.red,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ));

  static ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: kWhiteColor,
      colorScheme: _shrineColorScheme,
      fontFamily: Montserrat,
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      // inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      tabBarTheme: const TabBarTheme(
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  color: Colors.white) // color for indicator (underline)
              )),
    );
  }

  static final ColorScheme _shrineColorScheme = ColorScheme(
    primary: kPrimaryColor,
    secondary: kPrimaryDarkColor,
    surface: shrineSurfaceWhite,
    background: kWhiteColor,
    error: Colors.red,
    onPrimary: kWhiteColor,
    onSecondary: kWhiteColor,
    onSurface: kBlackColor,
    onBackground: kWhiteColor,
    onError: shrineSurfaceWhite,
    brightness: Brightness.light,
  );

  static Color shrinePink50 = const Color(0xFFFEEAE6);
  static Color shrinePink100 = const Color(0xFFFEDBD0);
  static Color shrinePink300 = const Color(0xFFFBB8AC);
  static Color shrinePink400 = const Color(0xFFEAA4A4);
  static Color shrineBrown900 = const Color(0xFF442B2D);
  static Color shrineBrown600 = const Color(0xFF7D4F52);
  static Color shrineErrorRed = const Color(0xFFC5032B);
  static Color shrineSurfaceWhite = const Color(0xFFFFFBFA);
  static Color shrineBackgroundWhite = Colors.white;

  static InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: kTextColor),
      gapPadding: 10,
    );
    return InputDecorationTheme(
      // If  you are using latest version of flutter then lable text and hint text shown like this
      // if you r using flutter less then 1.20.* then maybe this is not working properly
      // if we are define our floatingLabelBehavior in our theme then it's not applayed
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
    );
  }

  static TextTheme textTheme() {
    return const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
    );
  }

  static AppBarTheme appBarTheme() {
    return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      // brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      // textTheme: TextTheme(
      //   headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      // ),
    );
  }
}
