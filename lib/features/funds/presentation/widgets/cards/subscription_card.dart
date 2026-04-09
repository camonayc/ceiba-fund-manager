import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/cards/base_card.dart';
import 'package:flutter/material.dart';

class SubscriptionCard extends BaseCard<Subscription> {
  SubscriptionCard({
    super.key,
    required this.subscription,
    required this.onCancelSubscription,
  }) : super(
         id: subscription.fundId,
         name: subscription.fundName,
         categoryLabel: subscription.fundCategory,
         minimumAmount: subscription.amount,
         buttonText: 'Cancelar suscripción',
         buttonStye: ElevatedButton.styleFrom(
           backgroundColor: AppColors.danger,
         ),
         onPressed: () => onCancelSubscription(subscription),
       );

  final Subscription subscription;
  final Function(Subscription value) onCancelSubscription;
}
