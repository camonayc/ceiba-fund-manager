import 'package:equatable/equatable.dart';

class Subscription extends Equatable {
  const Subscription({
    required this.id,
    required this.fundId,
    required this.fundName,
    required this.fundCategory,
    required this.amount,
    required this.minimumAmount,
    required this.subscribedAt,
  });
  final String id;
  final int fundId;
  final String fundName;
  final String fundCategory;
  final double amount;
  final double minimumAmount;
  final DateTime subscribedAt;

  @override
  List<Object?> get props => [id, fundId];
}
