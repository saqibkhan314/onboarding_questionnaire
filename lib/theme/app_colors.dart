import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryAccent = Color(0xFF8B5CF6);
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryAccent = Color(0xFF34D399);
  
  // Base Colors
  static const Color base1 = Color(0xFF000000);
  static const Color base2 = Color(0xFF111827);
  static const Color base3 = Color(0xFF1F2937);
  
  // Text Colors
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xFFE5E7EB);
  static const Color text3 = Color(0xFF9CA3AF);
  static const Color text4 = Color(0xFF6B7280);
  
  // Surface Colors
  static const Color surfaceDark = Color(0xFF111827);
  static const Color surfaceMedium = Color(0xFF1F2937);
  static const Color surfaceLight = Color(0xFF374151);
  static const Color surfaceWhite2 = Color(0x14FFFFFF);
  
  // Border Colors
  static const Color border1 = Color(0xFF374151);
  static const Color border2 = Color(0xFF4B5563);
  static const Color border3 = Color(0xFF6366F1);
  
  // Effect Colors
  static const Color effectBgBlur80 = Color(0xCC000000);
  
  // State Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryAccent],
  );
  
  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [base1, base2],
  );
  
  static const Gradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceDark, surfaceMedium],
  );
}