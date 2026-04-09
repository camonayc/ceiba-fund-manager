import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/fund.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/dialogs/base_dialog.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/dialogs/dialog_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SubscribeDialog extends BaseDialog<Fund> {
  SubscribeDialog({
    super.key,
    required super.item,
    required this.balance,
    required this.onSubscribe,
    required super.onCancel,
  }) : super(
         onConfirm: null,
         body: _SubscribeForm(
           fund: item,
           balance: balance,
           onNotificationChanged: (type) {},
           onCancel: onCancel,
           onConfirm: (amount, notification) {
             onSubscribe(amount, notification);
           },
         ),
       );

  final double balance;
  final void Function(double, NotificationType) onSubscribe;
}

class _SubscribeForm extends StatefulWidget {
  const _SubscribeForm({
    required this.fund,
    required this.balance,
    required this.onNotificationChanged,
    required this.onCancel,
    required this.onConfirm,
  });
  final Fund fund;
  final double balance;
  final ValueChanged<NotificationType> onNotificationChanged;
  final VoidCallback onCancel;
  final void Function(double, NotificationType) onConfirm;

  @override
  State<_SubscribeForm> createState() => _SubscribeFormState();
}

class _SubscribeFormState extends State<_SubscribeForm> {
  late TextEditingController _controller;
  late NotificationType _notification;
  late double enteredAmount;
  late bool hasSufficientBalance;
  late bool meetsMinimum;
  late bool canSubmit;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.text = widget.fund.minimumAmount.toStringAsFixed(0);
    _notification = NotificationType.email;
    enteredAmount = double.tryParse(_controller.text.replaceAll('.', '')) ?? 0;
    hasSufficientBalance = enteredAmount <= widget.balance;
    meetsMinimum = enteredAmount >= widget.fund.minimumAmount;

    canSubmit = hasSufficientBalance && meetsMinimum;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChangeNotification(NotificationType type) {
    setState(() => _notification = type);
    widget.onNotificationChanged(type);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Monto a invertir', style: AppTextStyles.bodySm),
          const SizedBox(height: 6),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              prefixText: 'COP \$ ',
            ),
          ),
          if (!meetsMinimum) ...[
            const SizedBox(height: 4),
            Text(
              'Mínimo: \$${widget.fund.minimumAmount.toStringAsFixed(0)}',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.danger),
            ),
          ],
          if (!hasSufficientBalance) ...[
            const SizedBox(height: 4),
            Text(
              'Saldo insuficiente',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: 14),

          const Text('Notificación', style: AppTextStyles.bodySm),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _NotifButton(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  selected: _notification == NotificationType.email,
                  onTap: () => _onChangeNotification(NotificationType.email),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _NotifButton(
                  icon: Icons.smartphone_rounded,
                  label: 'SMS',
                  selected: _notification == NotificationType.sms,
                  onTap: () => _onChangeNotification(NotificationType.sms),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          const Divider(height: 1),

          const SizedBox(height: 32),

          DialogAction(
            cancelText: 'Cancelar',
            confirmText: 'Confirmar',
            onCancel: widget.onCancel,
            onConfirm: canSubmit
                ? () {
                    context.pop();
                    widget.onConfirm(
                      double.tryParse(_controller.text) ?? 0,
                      _notification,
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class _NotifButton extends StatelessWidget {
  const _NotifButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color: selected ? AppColors.onPrimary : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.bodyMd.copyWith(
                color: selected ? AppColors.onPrimary : AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
