import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:dartz/dartz.dart';

class GetSubscriptionsUseCase {
  const GetSubscriptionsUseCase(this._repository);
  final FundsRepository _repository;

  Future<Either<Failure, List<Subscription>>> call() =>
      _repository.getSubscriptions();
}
