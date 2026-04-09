import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class MobileHeader extends StatelessWidget implements PreferredSizeWidget {
  const MobileHeader({
    super.key,
    required this.balance,
  });

  final double balance;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16,
      title: Row(
        children: [
          const Icon(Icons.trending_up_rounded, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BTG Pactual',
                style: AppTextStyles.labelMd.copyWith(fontSize: 14),
              ),
              Text(
                'Gestión de Fondos',
                style: AppTextStyles.bodySm.copyWith(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Saldo',
                style: AppTextStyles.bodySm.copyWith(fontSize: 10),
              ),
              Text(
                '\$${(balance / 1000).toStringAsFixed(0)}K',
                style: AppTextStyles.labelMd.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.border,
        ),
      ),
    );
  }
}
