import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:dartz/dartz.dart';

class SubscribeToFundUseCase {
  const SubscribeToFundUseCase(this._repository);
  final FundsRepository _repository;

  Future<Either<Failure, Unit>> call({
    required Fund fund,
    required double amount,
    required NotificationType notification,
  }) => _repository.subscribe(
    fund: fund,
    amount: amount,
    notification: notification,
  );
}
