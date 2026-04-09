import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_state.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/content_area.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/layouts/sidebar/app_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsBloc, FundsState>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              const AppSidebar(),
              const VerticalDivider(width: 1),
              Expanded(
                child: BlocSelector<FundsBloc, FundsState, String>(
                  selector: (state) => state.errorMessage ?? '',
                  builder: (context, state) {
                    return ContentArea(
                      errorMessage: state.isEmpty ? null : state,
                      child: child,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
