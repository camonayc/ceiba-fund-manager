import 'package:ceiba_fund_manager/core/design/breakpoints/responsive_context.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_state.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/empty_view.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/transaction/transaction_list.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/transaction/transaction_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsBloc, FundsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Historial de transacciones',
                style: AppTextStyles.displaySm,
              ),
              const SizedBox(height: 4),
              const Text(
                'Revisa todas tus suscripciones y cancelaciones',
                style: AppTextStyles.bodySm,
              ),
              const SizedBox(height: 24),
              if (state.status == FundsStatus.loading)
                const Center(child: CircularProgressIndicator())
              else if (state.transactions.isEmpty)
                EmptyView.history()
              else
                context.responsive(
                  mobile: TransactionList(transactions: state.transactions),
                  tablet: TransactionTable(transactions: state.transactions),
                ),
            ],
          ),
        );
      },
    );
  }
}
