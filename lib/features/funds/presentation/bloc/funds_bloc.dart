import 'package:ceiba_technical_test/core/error/failures.dart';
import 'package:ceiba_technical_test/features/funds/domain/usecases/funds_usecases.dart';
import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_event.dart';
import 'package:ceiba_technical_test/features/funds/presentation/bloc/funds_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundsBloc extends Bloc<FundsEvent, FundsState> {
  FundsBloc({
    required GetAllFundsUseCase getAllFunds,
    required GetSubscriptionsUseCase getSubscriptions,
    required GetTransactionsUseCase getTransactions,
    required GetBalanceUseCase getBalance,
    required SubscribeToFundUseCase subscribeToFund,
    required CancelSubscriptionUseCase cancelSubscription,
  }) : _getAllFunds = getAllFunds,
       _getSubscriptions = getSubscriptions,
       _getTransactions = getTransactions,
       _getBalance = getBalance,
       _subscribeToFund = subscribeToFund,
       _cancelSubscription = cancelSubscription,
       super(const FundsState()) {
    on<FundsLoadRequested>(_onLoad);
    on<FundsSubscribeRequested>(_onSubscribe);
    on<FundsCancelRequested>(_onCancel);
    on<FundsErrorCleared>(_onErrorCleared);
  }
  final GetAllFundsUseCase _getAllFunds;
  final GetSubscriptionsUseCase _getSubscriptions;
  final GetTransactionsUseCase _getTransactions;
  final GetBalanceUseCase _getBalance;
  final SubscribeToFundUseCase _subscribeToFund;
  final CancelSubscriptionUseCase _cancelSubscription;

  Future<void> _onLoad(
    FundsLoadRequested event,
    Emitter<FundsState> emit,
  ) async {
    emit(state.copyWith(status: FundsStatus.loading));

    await _reload(emit, useFailureStatus: true);
  }

  Future<void> _onSubscribe(
    FundsSubscribeRequested event,
    Emitter<FundsState> emit,
  ) async {
    final result = await _subscribeToFund(
      fund: event.fund,
      amount: event.amount,
      notification: event.notification,
    );

    if (result.isLeft()) {
      emit(state.copyWith(errorMessage: _failureMessage(result)));
      return;
    }

    await _reload(emit);
  }

  Future<void> _onCancel(
    FundsCancelRequested event,
    Emitter<FundsState> emit,
  ) async {
    final result = await _cancelSubscription(fundId: event.fundId);

    if (result.isLeft()) {
      emit(state.copyWith(errorMessage: _failureMessage(result)));
      return;
    }

    await _reload(emit);
  }

  Future<void> _onErrorCleared(
    FundsErrorCleared event,
    Emitter<FundsState> emit,
  ) async {
    emit(state.copyWith(clearError: true, status: FundsStatus.loading));
    await _reload(emit);
  }

  Future<void> _reload(
    Emitter<FundsState> emit, {
    bool useFailureStatus = false,
  }) async {
    final allFundsResult = await _getAllFunds();
    if (allFundsResult.isLeft()) {
      emit(
        state.copyWith(
          status: useFailureStatus ? FundsStatus.failure : state.status,
          errorMessage: _failureMessage(allFundsResult),
        ),
      );
      return;
    }

    final subscriptionsResult = await _getSubscriptions();
    if (subscriptionsResult.isLeft()) {
      emit(
        state.copyWith(
          status: useFailureStatus ? FundsStatus.failure : state.status,
          errorMessage: _failureMessage(subscriptionsResult),
        ),
      );
      return;
    }

    final transactionsResult = await _getTransactions();
    if (transactionsResult.isLeft()) {
      emit(
        state.copyWith(
          status: useFailureStatus ? FundsStatus.failure : state.status,
          errorMessage: _failureMessage(transactionsResult),
        ),
      );
      return;
    }

    final balanceResult = await _getBalance();
    if (balanceResult.isLeft()) {
      emit(
        state.copyWith(
          status: useFailureStatus ? FundsStatus.failure : state.status,
          errorMessage: _failureMessage(balanceResult),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: FundsStatus.success,
        allFunds: allFundsResult.getOrElse(() => const []),
        subscriptions: subscriptionsResult.getOrElse(() => const []),
        transactions: transactionsResult.getOrElse(() => const []),
        balance: balanceResult.getOrElse(() => 0),
        clearError: true,
      ),
    );
  }

  String _failureMessage<T>(Either<Failure, T> result) {
    return result.fold((failure) => failure.message, (_) => '');
  }
}
