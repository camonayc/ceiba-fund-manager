import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class TransactionBase extends StatelessWidget {
  const TransactionBase({
    super.key,
    required this.transactions,
    required this.child,
  });
  final List<Transaction> transactions;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}
