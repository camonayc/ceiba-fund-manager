import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:dartz/dartz.dart';

class GetTransactionsUseCase {
  const GetTransactionsUseCase(this._repository);
  final FundsRepository _repository;

  Future<Either<Failure, List<Transaction>>> call() =>
      _repository.getTransactions();
}
