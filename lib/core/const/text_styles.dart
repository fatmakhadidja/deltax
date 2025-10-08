import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle heading1({
    Color color = Colors.black,
    double fontSize = 32,
    FontWeight fontWeight = FontWeight.bold,
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontFamily: 'Poppins',
  );

  static TextStyle heading2({Color color = Colors.black,double fontSize = 14,}) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: color,
    fontFamily: 'Poppins',
  );

  // Body text
  static TextStyle body1({
    Color color = AppColors.darkGrey,
    double fontSize = 12,
    FontWeight fontWeight =FontWeight.w500
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontFamily: 'Poppins',
  );

  // Button
  static TextStyle button({Color color = Colors.white}) => TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: 0.5,
  );
}
