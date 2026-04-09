import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:dartz/dartz.dart';

abstract interface class FundsRepository {
  Future<Either<Failure, List<Fund>>> getAllFunds();
  Future<Either<Failure, List<Subscription>>> getSubscriptions();
  Future<Either<Failure, List<Transaction>>> getTransactions();
  Future<Either<Failure, double>> getBalance();

  Future<Either<Failure, Unit>> subscribe({
    required Fund fund,
    required double amount,
    required NotificationType notification,
  });

  Future<Either<Failure, Unit>> cancelSubscription({required int fundId});
}
