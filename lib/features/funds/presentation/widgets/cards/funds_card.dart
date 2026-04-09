import 'package:ceiba_technical_test/features/funds/domain/entities/fund.dart';
import 'package:ceiba_technical_test/features/funds/presentation/widgets/cards/base_card.dart';

class FundCard extends BaseCard<Fund> {
  FundCard({
    super.key,
    required this.fund,
    required this.onSubscribe,
  }) : super(
         id: fund.id,
         name: fund.name,
         categoryLabel: fund.categoryLabel,
         minimumAmount: fund.minimumAmount,
         buttonText: 'Suscribirse',
         buttonStye: null,
         onPressed: () => onSubscribe(fund),
       );
  final Fund fund;
  final Function(Fund value) onSubscribe;
}
