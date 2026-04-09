import 'package:ceiba_technical_test/core/di/injection_container.dart';
import 'package:ceiba_technical_test/core/service/dialog_service.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/domain/entities/transaction.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/cards/funds_card.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/dialogs/subscribe_dialog.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/grids/base_grid.dart';

class FundsGrid extends BaseGrid<Fund> {
  FundsGrid({
    super.key,
    required super.items,
    required this.balance,
    required this.availableFunds,
    required this.onConfirm,
  }) : super(
         card: (fund) => FundCard(
           fund: fund,
           onSubscribe: (_) async {
             final dialogs = sl<DialogService>();
             await dialogs.openDialog<void>(
               barrierDismissible: false,
               builder: (_) => SubscribeDialog(
                 item: fund,
                 balance: balance,
                 onSubscribe: (amount, notification) {
                   onConfirm(fund, amount, notification);
                 },
                 onCancel: dialogs.closeDialog,
               ),
             );
           },
         ),
       );

  final double balance;
  final List<Fund> availableFunds;
  final void Function(Fund fund, double amount, NotificationType notification)
  onConfirm;
}
