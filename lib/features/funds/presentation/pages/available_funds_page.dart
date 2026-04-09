import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_event.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_state.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/empty_view.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/grids/funds_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableFundsPage extends StatelessWidget {
  const AvailableFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsBloc, FundsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Fondos disponibles', style: AppTextStyles.displaySm),
              const SizedBox(height: 4),
              const Text(
                'Explora y suscríbete a fondos de inversión FPV y FIC',
                style: AppTextStyles.bodySm,
              ),
              const SizedBox(height: 24),

              if (state.status == FundsStatus.loading)
                const Center(child: CircularProgressIndicator())
              else if (state.availableFunds.isEmpty)
                EmptyView.funds()
              else
                BlocSelector<FundsBloc, FundsState, double>(
                  selector: (state) {
                    return state.balance;
                  },
                  builder: (context, balance) {
                    return FundsGrid(
                      items: state.availableFunds,
                      balance: balance,
                      availableFunds: state.availableFunds,
                      onConfirm: (fund, amount, notification) =>
                          context.read<FundsBloc>().add(
                            FundsSubscribeRequested(
                              fund: fund,
                              amount: amount,
                              notification: notification,
                            ),
                          ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
