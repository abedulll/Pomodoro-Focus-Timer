import 'package:flutter/material.dart';

// Definisi warna yang konsisten
const Color primaryRed = Colors.redAccent;
const Color primaryIndigo = Colors.indigo;

// Tema Terang (Light)
final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.grey.shade50,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryRed,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.black54),
  textTheme: Typography.blackMountainView.apply(bodyColor: Colors.black87),
  brightness: Brightness.light,
);

// Tema Gelap (Dark)
final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: primaryRed,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: Typography.whiteMountainView.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  brightness: Brightness.dark,
);
