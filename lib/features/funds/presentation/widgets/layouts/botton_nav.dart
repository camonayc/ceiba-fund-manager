import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/core/design/theme/app_textstyle.dart';
import 'package:ceiba_technical_test/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  static const _items = [
    (
      icon: Icons.grid_view_rounded,
      label: 'Fondos',
      route: AppRoutes.availableFunds,
    ),
    (
      icon: Icons.work_outline_rounded,
      label: 'Mis fondos',
      route: AppRoutes.myFunds,
    ),
    (icon: Icons.history_rounded, label: 'Historial', route: AppRoutes.history),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: _items.map((item) {
            final isActive = item.route == '/'
                ? location == '/'
                : location.startsWith(item.route);
            return Expanded(
              child: InkWell(
                onTap: () => context.go(item.route),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 20,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: AppTextStyles.bodySm.copyWith(
                          fontSize: 11,
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
