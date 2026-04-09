import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_state.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/content_area.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/layouts/botton_nav.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/layouts/mobile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsBloc, FundsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MobileHeader(
            balance: state.balance,
          ),
          body: BlocSelector<FundsBloc, FundsState, String>(
            selector: (state) => state.errorMessage ?? '',
            builder: (context, errorMessage) {
              return ContentArea(
                errorMessage: errorMessage.isEmpty ? null : errorMessage,
                child: child,
              );
            },
          ),
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}
