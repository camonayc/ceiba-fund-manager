import 'package:ceiba_fund_manager/core/design/theme/app_color.dart';
import 'package:ceiba_fund_manager/core/design/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message, required this.onClose});
  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.dangerBg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 16,
            color: AppColors.danger,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodySm.copyWith(color: AppColors.danger),
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: Text(
              'Cerrar',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}
