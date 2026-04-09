import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color primary = Color(
    0xFF0D0D0D,
  ); // near-black (nav active, buttons)
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Background
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(
    0xFFF5F5F5,
  ); // table header, saldo card

  // Sidebar
  static const Color sidebarBg = Color(0xFFFFFFFF);
  static const Color sidebarBorder = Color(0xFFE5E5E5);

  // Text
  static const Color textPrimary = Color(0xFF0D0D0D);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFFB0B0B0);

  // Border
  static const Color border = Color(0xFFE5E5E5);

  // Semantic
  static const Color success = Color(0xFF059669); // suscripcion (teal/green)
  static const Color danger = Color(0xFFDC2626); // cancelacion (red)
  static const Color dangerBg = Color(0xFFFEE2E2);
  static const Color cancelBtn = Color(0xFFF3F4F6); // "No, mantener"
}
