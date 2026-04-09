import 'package:ceiba_technical_test/features/funds/data/data_sources/funds_local_datasource.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/cancel_subscription_usecase.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/get_all_funds_usecase.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/get_balance_usecase.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/get_subscriptions_usecase.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/get_transactions_usecase.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/subscribe_to_fund_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockFundsRepository extends Mock implements FundsRepository {}

class MockFundsLocalDataSource extends Mock implements FundsLocalDataSource {}

class MockGetAllFundsUseCase extends Mock implements GetAllFundsUseCase {}

class MockGetSubscriptionsUseCase extends Mock
    implements GetSubscriptionsUseCase {}

class MockGetTransactionsUseCase extends Mock
    implements GetTransactionsUseCase {}

class MockGetBalanceUseCase extends Mock implements GetBalanceUseCase {}

class MockSubscribeToFundUseCase extends Mock
    implements SubscribeToFundUseCase {}

class MockCancelSubscriptionUseCase extends Mock
    implements CancelSubscriptionUseCase {}
