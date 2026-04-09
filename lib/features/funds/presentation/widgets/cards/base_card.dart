import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/core/design/theme/app_textstyle.dart';
import 'package:ceiba_technical_test/core/functions/format_amount.dart';
import 'package:ceiba_technical_test/core/functions/format_date.dart';
import 'package:flutter/material.dart';

class BaseCard<T> extends StatelessWidget {
  const BaseCard({
    super.key,
    required this.id,
    required this.name,
    required this.categoryLabel,
    required this.minimumAmount,
    required this.buttonText,
    required this.buttonStye,
    required this.onPressed,
    this.fundId,
    this.amount,
    this.subscribedAt,
  });

  final int id;
  final String name;
  final String categoryLabel;
  final double minimumAmount;

  final int? fundId;
  final double? amount;
  final DateTime? subscribedAt;

  final String buttonText;
  final VoidCallback onPressed;

  final ButtonStyle? buttonStye;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(categoryLabel, style: AppTextStyles.bodySm),
            ],
          ),
          const SizedBox(height: 6),
          Text(name, style: AppTextStyles.titleMd),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'Monto mínimo',
                  value: 'COP \$${formatAmount(minimumAmount)}',
                ),
              ),
              if (amount != null) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: _StatItem(
                    label: 'Monto invertido',
                    value: 'COP \$${formatAmount(amount!)}',
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          if (subscribedAt != null)
            _StatItem(
              label: 'Fecha de suscripción',
              value: formatDate(subscribedAt!),
            ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: buttonStye,
              child: Text(
                buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySm.copyWith(fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.bodyMd),
      ],
    );
  }
}
