import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarNavItem extends StatelessWidget {
  const SidebarNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
  });
  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final isActive = route == '/'
        ? location == '/'
        : location.startsWith(route);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: InkWell(
        onTap: () => context.go(route),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isActive ? AppColors.onPrimary : AppColors.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTextStyles.bodyMd.copyWith(
                  color: isActive
                      ? AppColors.onPrimary
                      : AppColors.textSecondary,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
