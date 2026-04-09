import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/core/design/theme/app_textstyle.dart';
import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_state.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/layouts/sidebar/saldo_card.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/layouts/sidebar/sidebar_nav_item.dart';
import 'package:ceiba_technical_test/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 208,
      color: AppColors.sidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Row(
              children: [
                const Icon(Icons.trending_up_rounded, size: 22),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BTG Pactual',
                      style: AppTextStyles.titleMd.copyWith(fontSize: 15),
                    ),
                    const Text(
                      'Gestión de Fondos',
                      style: AppTextStyles.bodySm,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Saldo card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: BlocBuilder<FundsBloc, FundsState>(
              buildWhen: (p, c) => p.balance != c.balance,
              builder: (context, state) => SaldoCard(balance: state.balance),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 8),

          // Nav items
          const SidebarNavItem(
            icon: Icons.grid_view_rounded,
            label: 'Fondos disponibles',
            route: AppRoutes.availableFunds,
          ),
          const SidebarNavItem(
            icon: Icons.work_outline_rounded,
            label: 'Mis fondos',
            route: AppRoutes.myFunds,
          ),
          const SidebarNavItem(
            icon: Icons.history_rounded,
            label: 'Historial',
            route: AppRoutes.history,
          ),
        ],
      ),
    );
  }
}
