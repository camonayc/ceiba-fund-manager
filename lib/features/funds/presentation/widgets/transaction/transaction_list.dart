import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/core/design/theme/app_textstyle.dart';
import 'package:ceiba_technical_test/core/functions/format_amount.dart';
import 'package:ceiba_technical_test/core/functions/format_date.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/transaction/transaction_base.dart';
import 'package:flutter/material.dart';

class TransactionList extends TransactionBase {
  TransactionList({
    super.key,
    required super.transactions,
  }) : super(
         child: _BodyList(transactions: transactions),
       );
}

class _BodyList extends StatelessWidget {
  const _BodyList({required this.transactions});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.asMap().entries.map((entry) {
        final i = entry.key;
        final t = entry.value;
        return Container(
          decoration: BoxDecoration(
            border: i == 0
                ? null
                : const Border(top: BorderSide(color: AppColors.border)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                t.isSubscription
                    ? Icons.arrow_circle_up_rounded
                    : Icons.arrow_circle_down_rounded,
                size: 20,
                color: t.isSubscription ? AppColors.danger : AppColors.success,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.isSubscription ? 'Suscripción' : 'Cancelación',
                      style: AppTextStyles.labelMd.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.fundName,
                      style: AppTextStyles.bodySm,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(formatDate(t.date), style: AppTextStyles.bodySm),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${t.isSubscription ? '-' : '+'}\$${formatAmount(t.amount)}',
                style: AppTextStyles.labelMd.copyWith(
                  color: t.isSubscription
                      ? AppColors.danger
                      : AppColors.success,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
