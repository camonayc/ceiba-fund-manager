import 'package:flutter/material.dart';

extension ColorAlphaExtension on Color {
  Color alphaPercent(num percent) =>
      withValues(alpha: (percent.clamp(0, 100)) / 100);
}
