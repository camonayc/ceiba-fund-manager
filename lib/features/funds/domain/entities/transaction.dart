import 'package:equatable/equatable.dart';

enum TransactionType { subscription, cancellation }

enum NotificationType { email, sms }

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.type,
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.date,
    this.notification,
  });
  final String id;
  final TransactionType type;
  final int fundId;
  final String fundName;
  final double amount;
  final DateTime date;
  final NotificationType? notification;

  bool get isSubscription => type == TransactionType.subscription;

  @override
  List<Object?> get props => [id];
}
