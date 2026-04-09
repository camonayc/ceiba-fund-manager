import 'package:ceiba_technical_test/core/service/dialog_service.dart';
import 'package:ceiba_technical_test/features/funds/data/data_sources/funds_local_datasource.dart';
import 'package:ceiba_technical_test/features/funds/data/repositories/funds_repository_impl.dart';
import 'package:ceiba_technical_test/features/funds/domain/repositories/funds_repository.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/funds_usecases.dart';
import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_bloc.dart';
import 'package:ceiba_technical_test/routing/app_router.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  // Services
  sl
    ..registerLazySingleton<DialogService>(
      () => DialogService(AppRouter.rootNavigatorKey),
    )
    // DataSources
    ..registerLazySingleton<FundsLocalDataSource>(
      () => FundsLocalDataSourceImpl(),
    )
    // Repositories
    ..registerLazySingleton<FundsRepository>(
      () => FundsRepositoryImpl(sl<FundsLocalDataSource>()),
    )
    // Use Cases
    ..registerLazySingleton(() => GetAllFundsUseCase(sl<FundsRepository>()))
    ..registerLazySingleton(
      () => GetSubscriptionsUseCase(sl<FundsRepository>()),
    )
    ..registerLazySingleton(() => GetTransactionsUseCase(sl<FundsRepository>()))
    ..registerLazySingleton(() => GetBalanceUseCase(sl<FundsRepository>()))
    ..registerLazySingleton(() => SubscribeToFundUseCase(sl<FundsRepository>()))
    ..registerLazySingleton(
      () => CancelSubscriptionUseCase(sl<FundsRepository>()),
    )
    // BLoC - factory so each page gets fresh if needed, but we share via BlocProvider
    ..registerFactory(
      () => FundsBloc(
        getAllFunds: sl<GetAllFundsUseCase>(),
        getSubscriptions: sl<GetSubscriptionsUseCase>(),
        getTransactions: sl<GetTransactionsUseCase>(),
        getBalance: sl<GetBalanceUseCase>(),
        subscribeToFund: sl<SubscribeToFundUseCase>(),
        cancelSubscription: sl<CancelSubscriptionUseCase>(),
      ),
    );
}
