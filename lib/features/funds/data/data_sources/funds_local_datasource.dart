import 'package:ceiba_fund_manager/core/error/exceptions.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/fund.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:uuid/uuid.dart';

abstract interface class FundsLocalDataSource {
  Future<List<Fund>> getAllFunds();
  Future<List<Subscription>> getSubscriptions();
  Future<List<Transaction>> getTransactions();
  Future<double> getBalance();
  Future<void> subscribe({
    required Fund fund,
    required double amount,
    required NotificationType notification,
  });
  Future<void> cancelSubscription({required int fundId});
}

class FundsLocalDataSourceImpl implements FundsLocalDataSource {
  static const _uuid = Uuid();

  double _balance = 500000;
  final List<Subscription> _subscriptions = [];
  final List<Transaction> _transactions = [];

  static final List<Fund> _allFunds = [
    const Fund(
      id: 1,
      name: 'FPV_BTG_PACTUAL_RECAUDADORA',
      category: FundCategory.fpv,
      minimumAmount: 75000,
    ),
    const Fund(
      id: 2,
      name: 'FPV_BTG_PACTUAL_ECOPETROL',
      category: FundCategory.fpv,
      minimumAmount: 125000,
    ),
    const Fund(
      id: 3,
      name: 'DEUDAPRIVADA',
      category: FundCategory.fic,
      minimumAmount: 50000,
    ),
    const Fund(
      id: 4,
      name: 'FDO-ACCIONES',
      category: FundCategory.fic,
      minimumAmount: 250000,
    ),
    const Fund(
      id: 5,
      name: 'FPV_BTG_PACTUAL_DINAMICA',
      category: FundCategory.fpv,
      minimumAmount: 100000,
    ),
  ];

  @override
  Future<List<Fund>> getAllFunds() async => List.unmodifiable(_allFunds);

  @override
  Future<List<Subscription>> getSubscriptions() async =>
      List.unmodifiable(_subscriptions);

  @override
  Future<List<Transaction>> getTransactions() async =>
      List.unmodifiable(_transactions.reversed.toList());

  @override
  Future<double> getBalance() async => _balance;

  @override
  Future<void> subscribe({
    required Fund fund,
    required double amount,
    required NotificationType notification,
  }) async {
    if (_balance < amount) {
      throw ValidationException('Saldo insuficiente');
    }
    if (amount < fund.minimumAmount) {
      throw ValidationException('El monto es menor al mínimo requerido');
    }
    if (_subscriptions.any((s) => s.fundId == fund.id)) {
      throw ValidationException('Ya estas suscrito a este fondo');
    }

    _balance -= amount;

    _subscriptions.add(
      Subscription(
        id: _uuid.v4(),
        fundId: fund.id,
        fundName: fund.name,
        fundCategory: fund.categoryLabel,
        amount: amount,
        minimumAmount: fund.minimumAmount,
        subscribedAt: DateTime.now(),
      ),
    );

    _transactions.add(
      Transaction(
        id: _uuid.v4(),
        type: TransactionType.subscription,
        fundId: fund.id,
        fundName: fund.name,
        amount: amount,
        date: DateTime.now(),
        notification: notification,
      ),
    );
  }

  @override
  Future<void> cancelSubscription({required int fundId}) async {
    final sub = _subscriptions.firstWhere(
      (s) => s.fundId == fundId,
      orElse: () => throw ValidationException('Suscripcion no encontrada'),
    );

    _balance += sub.amount;
    _subscriptions.removeWhere((s) => s.fundId == fundId);

    _transactions.add(
      Transaction(
        id: _uuid.v4(),
        type: TransactionType.cancellation,
        fundId: fundId,
        fundName: sub.fundName,
        amount: sub.amount,
        date: DateTime.now(),
      ),
    );
  }
}
