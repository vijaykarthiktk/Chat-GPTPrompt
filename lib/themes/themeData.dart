import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';

final accentColor = SystemTheme.accentColor.accent;

ThemeData themeDataLight = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: accentColor,
  brightness: Brightness.light,
);

ThemeData themeDataDark = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: accentColor,
  brightness: Brightness.dark,
);
