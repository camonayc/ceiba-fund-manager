import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_event.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/error_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({
    super.key,
    required this.child,
    this.errorMessage,
  });
  final Widget child;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (errorMessage == null) ...[
          const SizedBox.shrink(),
        ] else
          ErrorBanner(
            message: errorMessage!,
            onClose: () =>
                context.read<FundsBloc>().add(const FundsErrorCleared()),
          ),
        Expanded(child: child),
      ],
    );
  }
}
