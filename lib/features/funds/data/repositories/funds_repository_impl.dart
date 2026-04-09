import 'package:ceiba_technical_test/core/error/exceptions.dart';
import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/data/data_sources/funds_local_datasource.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:dartz/dartz.dart';

class FundsRepositoryImpl implements FundsRepository {
  const FundsRepositoryImpl(this._dataSource);
  final FundsLocalDataSource _dataSource;

  @override
  Future<Either<Failure, List<Fund>>> getAllFunds() =>
      _execute(() => _dataSource.getAllFunds());

  @override
  Future<Either<Failure, List<Subscription>>> getSubscriptions() =>
      _execute(() => _dataSource.getSubscriptions());

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() =>
      _execute(() => _dataSource.getTransactions());

  @override
  Future<Either<Failure, double>> getBalance() =>
      _execute(() => _dataSource.getBalance());

  @override
  Future<Either<Failure, Unit>> subscribe({
    required Fund fund,
    required double amount,
    required NotificationType notification,
  }) => _executeUnit(
    () => _dataSource.subscribe(
      fund: fund,
      amount: amount,
      notification: notification,
    ),
  );

  @override
  Future<Either<Failure, Unit>> cancelSubscription({required int fundId}) =>
      _executeUnit(() => _dataSource.cancelSubscription(fundId: fundId));

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final value = await action();
      return Right(value);
    } on Exception catch (exception) {
      return Left(_mapExceptionToFailure(exception));
    } on Error catch (_) {
      return const Left(ServerFailure('Ocurrio un error inesperado'));
    }
  }

  Future<Either<Failure, Unit>> _executeUnit(
    Future<void> Function() action,
  ) async {
    final result = await _execute(action);
    return result.fold(Left.new, (_) => const Right(unit));
  }

  Failure _mapExceptionToFailure(Exception exception) {
    if (exception is ValidationException) {
      return ValidationFailure(exception.message);
    }
    if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    }
    if (exception is CacheException) {
      return CacheFailure(exception.message);
    }
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    }

    return ServerFailure(exception.toString());
  }
}
