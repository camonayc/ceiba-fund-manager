import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:ceiba_fund_manager/core/functions/format_amount.dart';
import 'package:ceiba_fund_manager/core/functions/format_date.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/transaction/transaction_base.dart';
import 'package:flutter/material.dart';

class TransactionTable extends TransactionBase {
  TransactionTable({super.key, required super.transactions})
    : super(
        child: _BodyTable(transactions: transactions),
      );
}

class _BodyTable extends StatelessWidget {
  const _BodyTable({required this.transactions});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(150),
        1: FlexColumnWidth(260),
        2: FixedColumnWidth(120),
        3: FixedColumnWidth(140),
        4: FixedColumnWidth(120),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppColors.surfaceVariant),
          children: ['Tipo', 'Fondo', 'Monto', 'Fecha', 'Notificación']
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    h,
                    style: AppTextStyles.labelSm.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        ...transactions.map((t) => _buildRow(t)),
      ],
    );
  }

  TableRow _buildRow(Transaction t) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                t.isSubscription
                    ? Icons.arrow_circle_up_rounded
                    : Icons.arrow_circle_down_rounded,
                size: 16,
                color: t.isSubscription ? AppColors.danger : AppColors.success,
              ),
              const SizedBox(width: 6),
              Text(
                t.isSubscription ? 'Suscripción' : 'Cancelación',
                style: AppTextStyles.bodyMd,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(
            t.fundName,
            style: AppTextStyles.bodyMd,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(
            '${t.isSubscription ? '-' : '+'}\$${formatAmount(t.amount)}',
            style: AppTextStyles.bodyMd.copyWith(
              color: t.isSubscription ? AppColors.danger : AppColors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(
            formatDate(t.date),
            style: AppTextStyles.bodyMd,
          ),
        ),
        // Notification
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: t.notification != null
              ? Row(
                  children: [
                    Icon(
                      t.notification == NotificationType.email
                          ? Icons.email_outlined
                          : Icons.smartphone_rounded,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      t.notification == NotificationType.email
                          ? 'Email'
                          : 'SMS',
                      style: AppTextStyles.bodySm,
                    ),
                  ],
                )
              : const Text('—', style: AppTextStyles.bodySm),
        ),
      ],
    );
  }
}
