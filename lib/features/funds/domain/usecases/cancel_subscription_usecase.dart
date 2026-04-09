import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:dartz/dartz.dart';

class CancelSubscriptionUseCase {
  const CancelSubscriptionUseCase(this._repository);
  final FundsRepository _repository;

  Future<Either<Failure, Unit>> call({required int fundId}) =>
      _repository.cancelSubscription(fundId: fundId);
}
