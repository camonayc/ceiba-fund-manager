import 'package:ceiba_fund_manager/core/error/failures.dart';
import 'package:ceiba_fund_manager/features/funds/domain/repositories/funds_repository.dart';
import 'package:dartz/dartz.dart';

class GetBalanceUseCase {
  const GetBalanceUseCase(this._repository);
  final FundsRepository _repository;

  Future<Either<Failure, double>> call() => _repository.getBalance();
}
