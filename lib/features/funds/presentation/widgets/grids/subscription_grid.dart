import 'package:ceiba_fund_manager/core/di/injection_container.dart';
import 'package:ceiba_fund_manager/core/service/dialog_service.dart';
import 'package:ceiba_fund_manager/features/funds/domain/entities/subscription.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/cards/subscription_card.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/dialogs/confirm_cancel_dialog.dart';
import 'package:ceiba_fund_manager/features/funds/presentation/widgets/grids/base_grid.dart';

class SubscriptionGrid extends BaseGrid {
  SubscriptionGrid({
    super.key,
    required super.items,
    required this.onConfirm,
  }) : super(
         card: (item) => SubscriptionCard(
           subscription: item,
           onCancelSubscription: (value) async {
             final dialogs = sl<DialogService>();
             await dialogs.openDialog(
               builder: (context) {
                 return ConfirmCancelDialog(
                   item: item,
                   onCancelSubscription: onConfirm,
                   onCancel: () {
                     dialogs.closeDialog();
                   },
                 );
               },
             );
           },
         ),
       );

  final void Function(Subscription subscription) onConfirm;
}
