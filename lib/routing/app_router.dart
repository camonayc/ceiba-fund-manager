import 'package:ceiba_fund_manager/core/di/injection_container.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/bloc/funds_event.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/pages/available_funds_page.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/pages/history_page.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/pages/my_funds_page.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/layouts/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const String root = '/';
  static const String availableFunds = '/fondos-disponibles';
  static const String myFunds = '/mis-fondos';
  static const String history = '/historial';
}

abstract final class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.availableFunds,
    routes: [
      GoRoute(
        path: AppRoutes.root,
        redirect: (context, state) => AppRoutes.availableFunds,
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider<FundsBloc>(
            create: (_) => sl<FundsBloc>()..add(const FundsLoadRequested()),
            child: AppShell(child: child),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.availableFunds,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AvailableFundsPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.myFunds,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MyFundsPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.history,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HistoryPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
