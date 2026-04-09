import 'package:ceiba_fund_manager/core/design/theme/app_theme.dart';
import 'package:ceiba_fund_manager/core/di/injection_container.dart';
import 'package:ceiba_fund_manager/core/service/dialog_service.dart';
import 'package:ceiba_fund_manager/routing/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    sl<DialogService>();
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}

final btgTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF0F1117),
    onSurface: Color(0xFFE8EAF0),
    primary: Color(0xFF3D6FFF),
    onPrimary: Colors.white,
    surfaceContainerHighest: Color(0xFF1A1D27),
    outline: Color(0xFF2A2D3A),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontFamily: 'monospace',
      color: Color(0xFFE8EAF0),
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(color: Color(0xFF6B7280)),
    bodyMedium: TextStyle(color: Color(0xFFE8EAF0)),
  ),
  scaffoldBackgroundColor: const Color(0xFF0F1117),
);
