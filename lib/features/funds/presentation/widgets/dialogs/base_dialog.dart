import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/core/design/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class BaseDialog<T> extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.item,
    this.onConfirm,
    required this.onCancel,
    required this.body,
    this.cancelText = 'Cancelar',
    this.confirmText = 'Confirmar',
    this.confirmButtonStyle,
  });
  final T item;
  final VoidCallback? onConfirm;
  final VoidCallback onCancel;

  final Widget body;

  final String cancelText;
  final String confirmText;
  final ButtonStyle? confirmButtonStyle;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cancelar suscripción',
                    style: AppTextStyles.titleMd,
                  ),
                  IconButton(
                    onPressed: onCancel,
                    icon: const Icon(Icons.close_rounded, size: 20),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Padding(padding: const EdgeInsets.all(16), child: body),
          ],
        ),
      ),
    );
  }
}
