import 'package:equatable/equatable.dart';

enum FundCategory { fpv, fic }

class Fund extends Equatable {
  const Fund({
    required this.id,
    required this.name,
    required this.category,
    required this.minimumAmount,
  });
  final int id;
  final String name;
  final FundCategory category;
  final double minimumAmount;

  String get categoryLabel => category == FundCategory.fpv ? 'FPV' : 'FIC';

  @override
  List<Object?> get props => [id, name, category, minimumAmount];
}
