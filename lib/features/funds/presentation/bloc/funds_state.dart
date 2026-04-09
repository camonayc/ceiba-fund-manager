import 'package:ceiba_fund_manager/features/funds/domain/entities/fund.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:equatable/equatable.dart';

enum FundsStatus { initial, loading, success, failure }

class FundsState extends Equatable {
  const FundsState({
    this.status = FundsStatus.initial,
    this.allFunds = const [],
    this.subscriptions = const [],
    this.transactions = const [],
    this.balance = 0,
    this.errorMessage,
  });
  final FundsStatus status;
  final List<Fund> allFunds;
  final List<Subscription> subscriptions;
  final List<Transaction> transactions;
  final double balance;
  final String? errorMessage;

  /// Funds the user has NOT subscribed to yet
  List<Fund> get availableFunds {
    final subscribedIds = subscriptions.map((s) => s.fundId).toSet();
    return allFunds.where((f) => !subscribedIds.contains(f.id)).toList();
  }

  FundsState copyWith({
    FundsStatus? status,
    List<Fund>? allFunds,
    List<Subscription>? subscriptions,
    List<Transaction>? transactions,
    double? balance,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FundsState(
      status: status ?? this.status,
      allFunds: allFunds ?? this.allFunds,
      subscriptions: subscriptions ?? this.subscriptions,
      transactions: transactions ?? this.transactions,
      balance: balance ?? this.balance,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    allFunds,
    subscriptions,
    transactions,
    balance,
    errorMessage,
  ];
}
