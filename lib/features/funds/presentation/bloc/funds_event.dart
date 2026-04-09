import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:equatable/equatable.dart';

abstract class FundsEvent extends Equatable {
  const FundsEvent();
  @override
  List<Object?> get props => [];
}

class FundsLoadRequested extends FundsEvent {
  const FundsLoadRequested();
}

class FundsSubscribeRequested extends FundsEvent {
  const FundsSubscribeRequested({
    required this.fund,
    required this.amount,
    required this.notification,
  });
  final Fund fund;
  final double amount;
  final NotificationType notification;

  @override
  List<Object?> get props => [fund, amount, notification];
}

class FundsCancelRequested extends FundsEvent {
  const FundsCancelRequested({required this.fundId});
  final int fundId;

  @override
  List<Object?> get props => [fundId];
}

class FundsErrorCleared extends FundsEvent {
  const FundsErrorCleared();
}
