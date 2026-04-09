import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/core/design/theme/app_textstyle.dart';
import 'package:ceiba_technical_test/core/functions/format_amount.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/dialogs/base_dialog.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/dialogs/dialog_actions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmCancelDialog extends BaseDialog<Subscription> {
  ConfirmCancelDialog({
    super.key,
    required super.item,
    required super.onCancel,
    required this.onCancelSubscription,
  }) : super(
         body: _CancelSubsBody(
           subscription: item,
           onConfirm: () => onCancelSubscription(item),
           onCancel: onCancel,
         ),
       );

  final void Function(Subscription subscription) onCancelSubscription;
}

class _CancelSubsBody extends StatelessWidget {
  const _CancelSubsBody({
    required this.subscription,
    required this.onConfirm,
    required this.onCancel,
  });

  final Subscription subscription;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.bodyMd,
            children: [
              const TextSpan(
                text: '¿Estás seguro de que deseas cancelar tu suscripción a ',
              ),
              TextSpan(
                text: subscription.fundName,
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const TextSpan(text: '?'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Amount row
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Monto a recuperar:',
                style: AppTextStyles.bodySm,
              ),
              Text(
                'COP \$${formatAmount(subscription.amount)}',
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Info note
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 15,
              color: AppColors.textSecondary,
            ),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'El monto será devuelto a tu saldo disponible inmediatamente.',
                style: AppTextStyles.bodySm,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        const Divider(height: 1),

        const SizedBox(height: 32),

        DialogAction(
          cancelText: 'No, mantener',
          confirmText: 'Sí, cancelar',
          isConfirm: false,
          onCancel: onCancel,
          onConfirm: () {
            context.pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}
