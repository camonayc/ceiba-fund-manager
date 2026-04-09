import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllFundsUseCase {
  const GetAllFundsUseCase(this._repository);
  final FundsRepository _repository;

  Future<Either<Failure, List<Fund>>> call() => _repository.getAllFunds();
}
