import 'package:ceiba_technical_test/core/design/theme/app_color.dart';
import 'package:ceiba_technical_test/core/design/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  factory EmptyView.funds() {
    return const EmptyView(
      title: '¡No hay fondos disponibles por el momento!',
      subtitle: 'Puedes gestionar tus suscripciones en "Mis fondos"',
    );
  }

  factory EmptyView.subscriptions() {
    return const EmptyView(
      title: '¡No tienes suscripciones activas!',
      subtitle: 'Explora los fondos disponibles y realiza tu primera inversión',
    );
  }

  factory EmptyView.history() {
    return const EmptyView(
      icon: Icons.history_rounded,
      title: 'No tienes transacciones registradas',
      subtitle: 'Tus movimientos aparecerán aquí cuando realices una operación',
    );
  }

  const EmptyView({
    super.key,
    this.icon = Icons.work_outline_rounded,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          children: [
            Icon(
              icon,
              size: 52,
              color: AppColors.textDisabled,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodySm,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
