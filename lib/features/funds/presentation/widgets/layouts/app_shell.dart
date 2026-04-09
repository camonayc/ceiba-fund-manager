import 'package:ceiba_technical_test/features/funds/presentation/widgets/layouts/desktop_layout.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/layouts/mobile_layout.dart';
import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > 1024;
    return isDesktop ? DesktopLayout(child: child) : MobileLayout(child: child);
  }
}
