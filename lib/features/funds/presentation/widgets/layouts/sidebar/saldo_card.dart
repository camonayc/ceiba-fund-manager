import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:ceiba_fund_manager/core/functions/format_amount.dart';
import 'package:flutter/material.dart';

class SaldoCard extends StatelessWidget {
  const SaldoCard({super.key, required this.balance});
  final double balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Saldo disponible', style: AppTextStyles.bodySm),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.wallet_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                'COP \$${formatAmount(balance)}',
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
