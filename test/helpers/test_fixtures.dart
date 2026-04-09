import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';

const tFpvFund = Fund(
  id: 1,
  name: 'FPV_BTG_PACTUAL_RECAUDADORA',
  category: FundCategory.fpv,
  minimumAmount: 75000,
);

const tFicFund = Fund(
  id: 3,
  name: 'DEUDAPRIVADA',
  category: FundCategory.fic,
  minimumAmount: 50000,
);

final tSubscription = Subscription(
  id: 'test-sub-id',
  fundId: 1,
  fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
  fundCategory: 'FPV',
  amount: 75000,
  minimumAmount: 75000,
  subscribedAt: DateTime(2024, 1, 15),
);

final tTransaction = Transaction(
  id: 'test-tx-id',
  type: TransactionType.subscription,
  fundId: 1,
  fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
  amount: 75000,
  date: DateTime(2024, 1, 15),
  notification: NotificationType.email,
);

const tAllFunds = [tFpvFund, tFicFund];
