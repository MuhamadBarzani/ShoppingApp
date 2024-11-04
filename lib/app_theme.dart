import 'package:flutter/material.dart';

class AppTheme {
  // Color constants
  static const Color primaryColor = Color.fromARGB(255, 255, 191, 0);
  static const Color secondaryColor = Colors.white;
  static const Color textPrimaryColor = Color.fromRGBO(48, 48, 48, 1);
  static const Color errorColor = Colors.red;
  
  // Text Styles
  static const TextStyle shadowedText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(blurRadius: 10.0, color: primaryColor, offset: Offset(0, 0)),
      Shadow(blurRadius: 20.0, color: Colors.black, offset: Offset(0, 0)),
      Shadow(blurRadius: 30.0, color: Colors.black, offset: Offset(0, 0)),
    ],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "Lato",
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: Colors.grey[200]!,
        error: errorColor,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontWeight: FontWeight.bold),
        bodySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(35),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(35),
        ),
        hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        prefixIconColor: Colors.grey,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: primaryColor,
          foregroundColor: textPrimaryColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200],
        selectedColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}