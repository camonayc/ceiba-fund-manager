import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class DialogAction extends StatelessWidget {
  const DialogAction({
    super.key,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    this.onConfirm,
    this.isConfirm = true,
  });

  final String cancelText;
  final String confirmText;

  final VoidCallback onCancel;
  final VoidCallback? onConfirm;

  final bool isConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            child: Text(
              cancelText,
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirm,
            style: isConfirm
                ? null
                : ElevatedButton.styleFrom(
                    backgroundColor: AppColors.danger,
                  ),
            child: Text(
              confirmText,
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
