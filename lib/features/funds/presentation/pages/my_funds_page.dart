import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_event.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_state.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/empty_view.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/grids/subscription_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFundsPage extends StatelessWidget {
  const MyFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsBloc, FundsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mis fondos', style: AppTextStyles.displaySm),
              const SizedBox(height: 4),
              const Text(
                'Gestiona tus inversiones actuales',
                style: AppTextStyles.bodySm,
              ),
              const SizedBox(height: 24),
              if (state.status == FundsStatus.loading)
                const Center(child: CircularProgressIndicator())
              else if (state.subscriptions.isEmpty)
                EmptyView.subscriptions()
              else
                SubscriptionGrid(
                  items: state.subscriptions,
                  onConfirm: (subscription) => context.read<FundsBloc>().add(
                    FundsCancelRequested(
                      fundId: subscription.fundId,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
